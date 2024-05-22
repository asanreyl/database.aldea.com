
-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP PROCEDURE IF EXISTS `aldeadb`.`getUserList`;

DELIMITER $$   
CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`getUserList`(_request JSON)
BEGIN

  select JSON_ARRAYAGG(
    JSON_OBJECT(
        'idUsuario', encrypt(u.idUsuario), 
        'nombre', u.nombre,
        'apellidos', u.apellidos,
        'email', u.email,
        'clave', u.clave,
        'active', if(u.deleted is null, 1, 0))
  ) as data_json
  from usuarios u;

END$$
DELIMITER;
