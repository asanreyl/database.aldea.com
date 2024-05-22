
-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`getWatterMeterList`;

DELIMITER $$   
CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`getWatterMeterList`(_request JSON)
BEGIN

  select JSON_ARRAYAGG(
    JSON_OBJECT(
        'idContador', encrypt(c.`idContador`), 
        'nombre', c.`nombre`,
        'observaciones', c.`observaciones`,
        'active', if(c.`deleted` is null, 1, 0))
  ) as data_json
  from contadores c;

END$$
DELIMITER;
