-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`getWatterMeterReadingList`;

DELIMITER $$   
CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`getWatterMeterReadingList`(_request JSON)
BEGIN
 
  declare _idContador int default decrypt(_request->>'$.wattermeterId');
  declare _fecha varchar(30) DEFAULT jsonToMysqlDateTime(_request->>'$.date');
  declare _fechaLunes DATE; 
  declare _fechaDomingo DATE;
  declare _result JSON; 

   -- Eliminar tablas temporales
    DROP TEMPORARY TABLE IF EXISTS fechas_unicas;
    DROP TEMPORARY TABLE IF EXISTS lecturas_combinadas;

    -- Calcular el lunes y el domingo de la semana de la fecha especificada
    SET _fechaLunes = DATE_SUB(_fecha, INTERVAL WEEKDAY(_fecha) DAY);
    SET _fechaDomingo = DATE_ADD(_fechaLunes, INTERVAL 6 DAY);


    -- Crear una tabla temporal con todas las fechas únicas de lecturas para cada contador
    CREATE TEMPORARY TABLE fechas_unicas AS (
        SELECT idContador, DATE(fecha) AS fecha_dia, TIME(fecha) AS hora,
            CASE
                WHEN TIME(fecha) < '14:00:00' THEN 'M'
                ELSE 'T'
            END AS periodo
        FROM lecturascl
        WHERE DATE(fecha) BETWEEN _fechaLunes AND _fechaDomingo
        UNION
        SELECT idContador, DATE(fecha) AS fecha_dia, TIME(fecha) AS hora,
            CASE
                WHEN TIME(fecha) < '14:00:00' THEN 'M'
                ELSE 'T'
            END AS periodo
        FROM lecturasph
        WHERE DATE(fecha) BETWEEN _fechaLunes AND _fechaDomingo
        UNION
        SELECT idContador, DATE(fecha) AS fecha_dia, TIME(fecha) AS hora,
            CASE
                WHEN TIME(fecha) < '14:00:00' THEN 'M'
                ELSE 'T'
            END AS periodo
        FROM lecturasmetroscubicos
        WHERE DATE(fecha) BETWEEN _fechaLunes AND _fechaDomingo
    );

    -- Combinamos las fechas únicas con cada tabla de lecturas
    CREATE TEMPORARY TABLE lecturas_combinadas AS (
        SELECT f.idcontador, f.fecha_dia, f.hora, f.periodo, 
        	c.valorCloro AS valor_cl, 
        	p.valorPh AS valor_ph, 
        	v.valorMCubicos AS valor_volumen
        FROM fechas_unicas f
        LEFT JOIN (SELECT idContador, DATE(fecha) AS fecha_dia, TIME(fecha) AS hora,
            CASE
                WHEN TIME(fecha) < '14:00:00' THEN 'M'
                ELSE 'T'
            END AS periodo, valorCloro FROM lecturascl) c 
            ON f.idContador = c.idContador AND f.fecha_dia = c.fecha_dia AND f.hora = c.hora AND f.periodo = c.periodo
        LEFT JOIN (SELECT idContador, DATE(fecha) AS fecha_dia, TIME(fecha) AS hora,
            CASE
                WHEN TIME(fecha) < '14:00:00' THEN 'M'
                ELSE 'T'
            END AS periodo, valorPh FROM lecturasph) p 
            ON f.idContador = p.idContador AND f.fecha_dia = p.fecha_dia AND f.hora = p.hora AND f.periodo = p.periodo
        LEFT JOIN (SELECT idContador, DATE(fecha) AS fecha_dia, TIME(fecha) AS hora,
            CASE
                WHEN TIME(fecha) < '14:00:00' THEN 'M'
                ELSE 'T'
            END AS periodo, valorMCubicos FROM lecturasmetroscubicos) v 
            ON f.idContador = v.idContador AND f.fecha_dia = v.fecha_dia AND f.hora = v.hora AND f.periodo = v.periodo
    );

SELECT JSON_ARRAYAGG(
        JSON_OBJECT(
            'idContador', encrypt(lc.idcontador),
            'nombre', co.nombre,
            'fecha', lc.fecha_dia,
            'hora', lc.hora,
            'periodo', lc.periodo,
            'cl', round(lc.valor_cl,2),
            'ph', round(lc.valor_ph,2),
            'volumen', round(lc.valor_volumen,2)
        )
    ) AS data_json
    FROM lecturas_combinadas lc
    LEFT JOIN contadores co ON lc.idcontador = co.idcontador
    WHERE lc.idcontador = _idContador
    ORDER BY lc.fecha_dia, lc.periodo;


    -- Eliminar tablas temporales
    DROP TEMPORARY TABLE IF EXISTS fechas_unicas;
    DROP TEMPORARY TABLE IF EXISTS lecturas_combinadas;
  
END$$
DELIMITER;
