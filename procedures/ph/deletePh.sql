-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`deletePh`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`deletePh`(_request JSON)
BEGIN
  
  declare _idPhToEliminate int default decrypt(_request->>'$.id');
  declare _idUserDeleted int default decrypt(_request->>'$.userGUID'); 

  -- if (_idUser is null || _idUser ==="")
  -- end if 

  update lecturasph
    set `deleted` = CURRENT_TIMESTAMP, 
        `deletedId` = _idUserDeleted
  where `idLecturaPh` = _idPhToEliminate; 


END$$
DELIMITER;
