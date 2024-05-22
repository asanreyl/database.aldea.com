
-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`getUser`;

DELIMITER $$   
CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`getUser`(_request JSON)
BEGIN
  
  declare _idUserToSelect int default decrypt(_request->>'$.id');

  select JSON_OBJECT (
      'idUsuario', encrypt(u.`idUsuario`), 
      'nombre', u.`nombre`,
      'apellidos', u.`apellidos`,
      'email', u.`email`,
      'clave', u.`clave`
    ) data_json
  from usuarios u
  where u.`idUsuario`=_idUserToSelect; 

END$$
DELIMITER;
