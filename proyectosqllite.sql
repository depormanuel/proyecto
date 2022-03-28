-- import to SQLite by running: sqlite3.exe db.sqlite3 -init sqlite.sql

PRAGMA journal_mode = MEMORY;
PRAGMA synchronous = OFF;
PRAGMA foreign_keys = OFF;
PRAGMA ignore_check_constraints = OFF;
PRAGMA auto_vacuum = NONE;
PRAGMA secure_delete = OFF;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS `empresa`;

CREATE TABLE `empresa` (
`nombre` TEXT NOT NULL,
`ciudad` TEXT NOT NULL,
`mail` TEXT NOT NULL,
`telefono` TEXT NOT NULL,
PRIMARY KEY (`nombre`)
);
LOCK TABLES `empresa` WRITE;
UNLOCK TABLES;
DROP TABLE IF EXISTS `evento`;

CREATE TABLE `evento` (
`mes` TEXT NOT NULL,
`ano` INTEGER NOT NULL,
`instalacion` TEXT NOT NULL,
`entidad` TEXT NOT NULL,
`actividad` TEXT NOT NULL,
`deporte` TEXT NOT NULL,
`id` TEXT NOT NULL,
PRIMARY KEY (`id`),
FOREIGN KEY (`entidad`) REFERENCES `empresa` (`nombre`)
);
LOCK TABLES `evento` WRITE;
UNLOCK TABLES;
DROP TABLE IF EXISTS `participan`;

CREATE TABLE `participan` (
`id` TEXT NOT NULL,
`id_Part` TEXT NOT NULL,
PRIMARY KEY (`id`,`id_Part`),
FOREIGN KEY (`id_Part`) REFERENCES `participante` (`id_Part`),
FOREIGN KEY (`id`) REFERENCES `evento` (`id`)
);
LOCK TABLES `participan` WRITE;
UNLOCK TABLES;
DROP TABLE IF EXISTS `participante`;

CREATE TABLE `participante` (
`nombre` TEXT NOT NULL,
`id_Part` TEXT NOT NULL,
`localidad` TEXT NOT NULL,
`telefono` TEXT NOT NULL,
PRIMARY KEY (`id_Part`)
);
LOCK TABLES `participante` WRITE;
UNLOCK TABLES;



CREATE INDEX `evento_entidad` ON `evento` (`entidad`);
CREATE INDEX `participan_id` ON `participan` (`id`);
CREATE INDEX `participan_id_Part` ON `participan` (`id_Part`);

COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
