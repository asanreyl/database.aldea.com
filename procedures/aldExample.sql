-- Active: 1715799975876@@127.0.0.1@3306@aldeadb
DROP PROCEDURE IF EXISTS `aldeadb`.`getUser`;

DELIMITER $$   

CREATE DEFINER=`root`@`localhost` PROCEDURE `aldeadb`.`getUser`(_request JSON)
BEGIN
  select * from usuarios where nombre = _request->'$.name';
END$$
DELIMITER;



