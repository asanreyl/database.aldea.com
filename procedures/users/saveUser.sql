
DROP PROCEDURE IF EXISTS `aldeadb`.`saveUser`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`saveUser`(_request JSON)
BEGIN
  
  declare _idUserToUpdate int DEFAULT if ((_request->>'$.id') is not null 
                                      AND (_request->>'$.id') <> 'null'
                                      AND (_request->>'$.id') <> '', decrypt(_request->>'$.id'), 0); 

  declare _nombre varchar(100) default _request->>'$.userName';
  declare _apellidos varchar(100) default _request->>'$.lastName'; 
  declare _email varchar(100) default _request->>'$.email';
  declare _pass varchar(100) default encrypt(_request->>'$.password');
  declare _userId int default decrypt(_request->>'$.userGUID'); 

  -- Es un nuevo usuario
  if (_idUserToUpdate = 0) then

    Insert Into usuarios (nombre, apellidos, email, clave, created, createdId) 
                values (_nombre, _apellidos, _email, _pass, CURRENT_TIMESTAMP, _userId); 
        
    select json_object ('guid', encrypt(LAST_INSERT_ID())) data_json;

  else  -- Actualizamos el usuario

    Update usuarios 
    Set 
        `nombre` = _nombre, 
        `apellidos` = _apellidos,
        `email` = _email,
        `clave` = _pass,  
        `modified` = CURRENT_TIMESTAMP,
        `modifiedId` = _userId
    Where 
        `idUsuario` = _idUserToUpdate; 
    
    select json_object ('guid', encrypt(_idUserToUpdate)) data_json;
  end if;


END$$
DELIMITER;
