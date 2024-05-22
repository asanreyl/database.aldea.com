
DROP PROCEDURE IF EXISTS `aldeadb`.`saveWatterMeter`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`saveWatterMeter`(_request JSON)
BEGIN
  
  declare _idWatterMatterToUpdate int DEFAULT if ((_request->>'$.id') is not null 
                                      AND (_request->>'$.id') <> 'null'
                                      AND (_request->>'$.id') <> '', decrypt(_request->>'$.id'), 0); 

  declare _nombre varchar(100) default _request->>'$.name';
  declare _observaciones varchar(100) default _request->>'$.observations'; 
  declare _userId int default decrypt(_request->>'$.userGUID'); 

  -- Es un nuevo contador
  if (_idWatterMatterToUpdate = 0) then

    Insert Into contadores (nombre, observaciones, created, createdId) 
                values (_nombre, _observaciones, CURRENT_TIMESTAMP, _userId); 
        
    select json_object ('guid', encrypt(LAST_INSERT_ID())) data_json;

  else  -- Actualizamos el contador

    Update contadores 
    Set 
        `nombre` = _nombre, 
        `observaciones` = _observaciones,
        `modified` = CURRENT_TIMESTAMP,
        `modifiedId` = _userId
    Where 
        `idContador` = _idWatterMatterToUpdate; 
    
    select json_object ('guid', encrypt(_idWatterMatterToUpdate)) data_json;
  end if;


END$$
DELIMITER;
