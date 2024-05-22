
-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`getWatterMeter`;

DELIMITER $$   
CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`getWatterMeter`(_request JSON)
BEGIN
  
  declare _idWatterMeterToSelect int default decrypt(_request->>'$.id');

  select JSON_OBJECT (
        'idContador', encrypt(c.`idContador`), 
        'nombre', c.`nombre`,
        'observaciones', c.`observaciones`,
        'active', if(c.`deleted` is null, 1, 0)) data_json
  from contadores c
  where c.`idContador`=_idWatterMeterToSelect; 

END$$
DELIMITER;
