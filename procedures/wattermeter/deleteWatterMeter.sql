-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`deleteWatterMeter`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`deleteWatterMeter`(_request JSON)
BEGIN
  
  declare _idWatterMeterToEliminate int default decrypt(_request->>'$.id');
  declare _idUserDeleted int default decrypt(_request->>'$.userGUID'); 

  -- if (_idUser is null || _idUser ==="")
  -- end if 

  update contadores 
    set `deleted` = CURRENT_TIMESTAMP, 
        `deletedId` = _idUserDeleted
  where `idContador` = _idWatterMeterToEliminate; 


END$$
DELIMITER;
