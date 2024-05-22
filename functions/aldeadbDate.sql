-- Active: 1715799975876@@127.0.0.1@3306@aldeadb

DROP FUNCTION IF EXISTS `aldeadb`.`jsonToDateTime`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `aldeadb`.`jsonToDateTime`(_value varchar(20)) 
RETURNS varchar(20) DETERMINISTIC
BEGIN

	RETURN DATE_FORMAT(STR_TO_DATE(_value,'%Y-%m-%dT%H:%i:%s'), "%d/%m/%Y %H:%i:%s");

END$$
DELIMITER $$;




DROP FUNCTION IF EXISTS `aldeadb`.`jsonToMysqlDateTime`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `aldeadb`.`jsonToMysqlDateTime`(_value varchar(50)) 
RETURNS varchar(30) DETERMINISTIC
begin
	return STR_TO_DATE(_value, '%Y-%m-%dT%H:%i:%s.%fZ');
END$$
DELIMITER $$;
