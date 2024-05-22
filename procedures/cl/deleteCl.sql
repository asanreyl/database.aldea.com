-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`deleteCl`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`deleteCl`(_request JSON)
BEGIN
  
  declare _idClToEliminate int default decrypt(_request->>'$.id');
  declare _idUserDeleted int default decrypt(_request->>'$.userGUID'); 

  -- if (_idUser is null || _idUser ==="")
  -- end if 

  update lecturascl
    set `deleted` = CURRENT_TIMESTAMP, 
        `deletedId` = _idUserDeleted
  where `idLecturaCl` = _idClToEliminate; 


END$$
DELIMITER;
