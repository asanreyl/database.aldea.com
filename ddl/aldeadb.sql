-- Active: 1715799975876@@127.0.0.1@3306@aldeadb


CREATE DATABASE `aldeadb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

-- aldeadb.usuarios definition

CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `clave` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isAdmin` tinyint NOT NULL DEFAULT '0',  -- administrador (1) - lector (0)
  `created` datetime NOT NULL,
  `createdId` int NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modifiedId` int DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedId` int DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- aldeadb.contadores definition

CREATE TABLE `contadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `observaciones` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `createdId` int NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modifiedId` int DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedId` int DEFAULT NULL,
  `isWatterCounter` tinyint NOT NULL DEFAULT '1',  -- 1 es un contador / 0 es un punto de muestreo
  PRIMARY KEY (`id`),
  KEY `contadores_usuarios_FK` (`createdId`),
  KEY `contadores_usuarios_FK_1` (`modifiedId`),
  KEY `contadores_usuarios_FK_2` (`deletedId`),
  CONSTRAINT `contadores_usuarios_FK` FOREIGN KEY (`createdId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `contadores_usuarios_FK_1` FOREIGN KEY (`modifiedId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `contadores_usuarios_FK_2` FOREIGN KEY (`deletedId`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- aldeadb.lecturasph definition

CREATE TABLE `lecturasph` (
  `idLecturaPh` int NOT NULL AUTO_INCREMENT,
  `idContador` int NOT NULL,
  `fecha` datetime NOT NULL,
  `valorPh` float NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `createdId` int NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modifiedId` int DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedId` int DEFAULT NULL,
  PRIMARY KEY (`idLecturaPh`),
  KEY `lecturasph_usuarios_FK` (`createdId`),
  KEY `lecturasph_usuarios_FK_1` (`modifiedId`),
  KEY `lecturasph_usuarios_FK_2` (`deletedId`),
  CONSTRAINT `lecturasph_usuarios_FK` FOREIGN KEY (`createdId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `lecturasph_usuarios_FK_1` FOREIGN KEY (`modifiedId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `lecturasph_usuarios_FK_2` FOREIGN KEY (`deletedId`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- aldeadb.lecturasmetroscubicos definition

CREATE TABLE `lecturasmetroscubicos` (
  `idLecturaMCubicos` int NOT NULL AUTO_INCREMENT,
  `idContador` int NOT NULL,
  `fecha` datetime NOT NULL,
  `valorMCubicos` float NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `createdId` int NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modifiedId` int DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedId` int DEFAULT NULL,
  PRIMARY KEY (`idLecturaMCubicos`),
  KEY `lecturasmetroscubicos_usuarios_FK` (`createdId`),
  KEY `lecturasmetroscubicos_usuarios_FK_1` (`modifiedId`),
  KEY `lecturasmetroscubicos_usuarios_FK_2` (`deletedId`),
  CONSTRAINT `lecturasmetroscubicos_usuarios_FK` FOREIGN KEY (`createdId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `lecturasmetroscubicos_usuarios_FK_1` FOREIGN KEY (`modifiedId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `lecturasmetroscubicos_usuarios_FK_2` FOREIGN KEY (`deletedId`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- aldeadb.lecturascl definition

CREATE TABLE `lecturascl` (
  `idLecturaCl` int NOT NULL AUTO_INCREMENT,
  `idContador` int NOT NULL,
  `fecha` datetime NOT NULL,
  `valorCloro` float NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `createdId` int NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modifiedId` int DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedId` int DEFAULT NULL,
  PRIMARY KEY (`idLecturaCl`),
  KEY `lecturascl_usuarios_FK` (`createdId`),
  KEY `lecturascl_usuarios_FK_1` (`modifiedId`),
  KEY `lecturascl_usuarios_FK_2` (`deletedId`),
  CONSTRAINT `lecturascl_usuarios_FK` FOREIGN KEY (`createdId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `lecturascl_usuarios_FK_1` FOREIGN KEY (`modifiedId`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `lecturascl_usuarios_FK_2` FOREIGN KEY (`deletedId`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



