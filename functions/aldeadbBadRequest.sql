-- Active: 1715799975876@@127.0.0.1@3306@aldeadb
DROP FUNCTION IF EXISTS `aldeadbBadRequest`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `aldeadbBadRequest`(_name text, _texto text, _codeStatus int) RETURNS json
    DETERMINISTIC
begin
	declare data_json text default '{}';
	declare _delim varchar(1) default '|';
	SET SESSION group_concat_max_len = 4294967295;
	if (_codeStatus = 0) then
		set _codeStatus = 400;
	end if;

	select json_object(
	"status", _codeStatus, 
	"errors", 
		-- JSON_ARRAYAGG(
convert(COALESCE(concat('[',group_concat(			
		json_object(
		"name", _name,
		"data", convert((
			select 
			-- JSON_ARRAYAGG(
			COALESCE(concat('[',group_concat(
				B.text
			),']'), '[]') 
			from (
			select
				SUBSTRING_INDEX(SUBSTRING_INDEX(_texto, _delim, f.num + 1), _delim, -1) text,
				f.num + 1 ID
			from factorial f
			where CHAR_LENGTH(_texto) - CHAR_LENGTH(REPLACE(_texto, _delim, ''))>=f.num) B
			where JSON_VALID(B.text) = 1), json), 
		"errors", convert(COALESCE(concat('[', (
			select 
			-- JSON_ARRAYAGG(
				group_concat(
				concat('"', B.text, '"')
				)
			from (
			select
				SUBSTRING_INDEX(SUBSTRING_INDEX(_texto, _delim, f.num + 1), _delim, -1) text
			from factorial f
			where CHAR_LENGTH(_texto) - CHAR_LENGTH(REPLACE(_texto, _delim, ''))>=f.num) B
			where JSON_VALID(B.text) = 0)
			,']'), '[]'), json)
		)
			),']'), '[]'), json)
		) 
	into data_json;

	return data_json;
END$$
DELIMITER $$;