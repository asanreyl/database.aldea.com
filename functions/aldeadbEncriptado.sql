
DROP FUNCTION IF EXISTS `aldeadb`.`encrypt`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `aldeadb`.`encrypt`(_text text) 
RETURNS text DETERMINISTIC
begin
	return to_base64(hex(aes_encrypt(_text, '*Pv2b9cNUl96yF5XbJHC5@')));
END$$

DELIMITER $$;

DROP FUNCTION IF EXISTS `aldeadb`.`decrypt`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `aldeadb`.`decrypt`(_text text) 
RETURNS VARBINARY(255) DETERMINISTIC
begin
	return aes_decrypt(unhex(from_base64(_text)), '*Pv2b9cNUl96yF5XbJHC5@');
END$$
DELIMITER $$;
