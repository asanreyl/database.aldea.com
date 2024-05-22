-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`deleteVolume`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`deleteVolume`(_request JSON)
BEGIN
  
  declare _idVolumenToEliminate int default decrypt(_request->>'$.id');
  declare _idUserDeleted int default decrypt(_request->>'$.userGUID'); 

  -- if (_idUser is null || _idUser ==="")
  -- end if 

  update lecturasmetroscubicos
    set `deleted` = CURRENT_TIMESTAMP, 
        `deletedId` = _idUserDeleted
  where `idLecturaMCubicos` = _idVolumenToEliminate; 


END$$
DELIMITER;
