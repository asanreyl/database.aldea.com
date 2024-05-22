-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`savePh`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`savePh`(_request JSON)
BEGIN
  
  declare _idPhToUpdate int DEFAULT if ((_request->>'$.id') is not null 
                                    AND (_request->>'$.id') <> 'null'
                                    AND (_request->>'$.id') <> '', decrypt(_request->>'$.id'), 0); 

  declare _idContador int default decrypt(_request->>'$.wattermeterId');
  declare _fecha varchar(30) DEFAULT jsonToMysqlDateTime(_request->>'$.date');
  declare _valor decimal(15,2) default replace(_request->>'$.value', ',', '.');
  declare _userId int default decrypt(_request->>'$.userGUID'); 

  -- Es un nuevo lectura de cloro
  if (_idPhToUpdate = 0) then

    Insert Into lecturasph (idcontador, fecha, valorPh, created, createdId) 
                values (_idContador, _fecha, _valor, CURRENT_TIMESTAMP, _userId); 
        
    select json_object ('guid', encrypt(LAST_INSERT_ID())) data_json;

  else  -- Actualizamos la lectura del cloro
    Update lecturasph
    Set 
        `idContador` = _idContador, 
        `fecha` = _fecha,
        `valorPh` = _valor,
        `modified` = CURRENT_TIMESTAMP,
        `modifiedId` = _userId
    Where 
        `idLecturaPh` = _idPhToUpdate; 
    
    select json_object ('guid', encrypt(_idPhToUpdate)) data_json;
  end if;


END$$
DELIMITER;