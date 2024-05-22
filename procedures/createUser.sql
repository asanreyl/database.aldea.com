
DROP PROCEDURE IF EXISTS `aldeadb`.`createUser`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`createUser`(_request JSON)
BEGIN
  
  Insert Into usuarios (nombre, apellidos, email, clave, created, createdId) 
  values (
    _request->>'$.userName', 
    _request->>'$.lastName', 
    _request->>'$.email', 
    encrypt(_request->>'$.password'),
    CURRENT_TIMESTAMP,
    decrypt(_request->>'$.userGUID')
  );

  Select encrypt(LAST_INSERT_ID()) as guid;

END$$
DELIMITER;
