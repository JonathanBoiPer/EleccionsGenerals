-- MySQL Workbench Forward Engineering

DROP SCHEMA IF EXISTS `Eleccions_Generals_GrupB`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Eleccions_Generals_GrupB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Eleccions_Generals_GrupB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Eleccions_Generals_GrupB` DEFAULT CHARACTER SET utf8 ;
USE `Eleccions_Generals_GrupB` ;

-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`comunitats_autonomes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`comunitats_autonomes` (
  `comunitat_aut_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `codi_ine` CHAR(2) NOT NULL,
  PRIMARY KEY (`comunitat_aut_id`),
  UNIQUE INDEX `uk_com_aut_codi_ine` (`codi_ine` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`provincies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`provincies` (
  `provincia_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comunitat_aut_id` TINYINT UNSIGNED NOT NULL,
  `nom` VARCHAR(45) NULL,
  `codi_ine` CHAR(2) NOT NULL,
  `num_escons` TINYINT UNSIGNED NULL COMMENT 'Numero d\'escons que li pertoquen a aquella provincia',
  PRIMARY KEY (`provincia_id`),
  UNIQUE INDEX `uk_provincies_codi_ine` (`codi_ine` ASC) VISIBLE,
  INDEX `idx_fk_provincies_comunitats_autonomes` (`comunitat_aut_id` ASC) VISIBLE,
  CONSTRAINT `fk_provincies_comunitats_autonomes`
    FOREIGN KEY (`comunitat_aut_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`comunitats_autonomes` (`comunitat_aut_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`municipis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`municipis` (
  `municipi_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NULL,
  `codi_ine` CHAR(3) NOT NULL,
  `provincia_id` TINYINT UNSIGNED NOT NULL,
  `districte` CHAR(2) NULL COMMENT 'Número de districte municipal , sinó el seu valor serà 99. Per exemple aquí municiís com Blanes el seu valor serà 99, però en ciutats com Barcelona hi haurà el número de districte',
  PRIMARY KEY (`municipi_id`),
  UNIQUE INDEX `uk_municipis_codi_ine_provincia_id` (`codi_ine` ASC, `provincia_id` ASC) VISIBLE,
  INDEX `idx_fk_municipis_provincies1` (`provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_municipis_provincies`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`provincies` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`eleccions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`eleccions` (
  `eleccio_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `data` DATE NOT NULL COMMENT 'Data (dia mes i any) de quan s\'han celebrat les eleccions',
  `any` YEAR GENERATED ALWAYS AS (YEAR(data))  COMMENT 'any el qual s\'han celebrat les eleccions',
  `mes` TINYINT GENERATED ALWAYS AS (MONTH(data)) STORED COMMENT 'El mes que s\'han celebrat les eleccions',
  PRIMARY KEY (`eleccio_id`),
  UNIQUE INDEX `uk_eleccions_any_mes` (`any` ASC, `mes` ASC) VISIBLE,
  UNIQUE INDEX `uk_eleccions_data` (`data` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`eleccions_municipis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`eleccions_municipis` (
  `eleccio_id` TINYINT UNSIGNED NOT NULL,
  `municipi_id` SMALLINT UNSIGNED NOT NULL,
  `num_meses` SMALLINT UNSIGNED NULL,
  `cens` INT UNSIGNED NULL,
  `vots_emesos` INT UNSIGNED GENERATED ALWAYS AS(vots_candidatures + vots_nuls + vots_blanc) COMMENT 'Número total de vots realitzats en el municipi',
  `vots_valids` INT UNSIGNED GENERATED ALWAYS AS(vots_candidatures + vots_blanc) COMMENT 'Número de vots es que tindran en compte: vots a candidatures + vots nuls',
  `vots_candidatures` INT UNSIGNED NULL COMMENT 'Total de vots a les candidatures\n',
  `vots_blanc` INT UNSIGNED NULL,
  `vots_nuls` INT UNSIGNED NULL,
  INDEX `idx_fk_eleccions_municipis_eleccions` (`eleccio_id` ASC) VISIBLE,
  INDEX `fk_eleccions_municipis_municipis` (`municipi_id` ASC) VISIBLE,
  UNIQUE INDEX `uk_eleccions_municipis` (`eleccio_id` ASC, `municipi_id` ASC) VISIBLE,
  PRIMARY KEY (`eleccio_id`, `municipi_id`),
  CONSTRAINT `fk_eleccions_municipis_municipis`
    FOREIGN KEY (`municipi_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`municipis` (`municipi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eleccions_municipis_eleccions`
    FOREIGN KEY (`eleccio_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`eleccions` (`eleccio_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`candidatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`candidatures` (
  `candidatura_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `eleccio_id` TINYINT UNSIGNED NOT NULL,
  `codi_candidatura` CHAR(6) NULL,
  `nom_curt` VARCHAR(50) NULL COMMENT 'Sigles de la candidatura',
  `nom_llarg` VARCHAR(150) NULL COMMENT 'Nom llarg de la candidatura (denominació)',
  `codi_acumulacio_provincia` CHAR(6) NULL COMMENT 'Codi de la candidatura d\'acumulació a nivell provincial.',
  `codi_acumulacio_ca` CHAR(6) NULL COMMENT 'Codi de la candidatura d\'acumulació a nivell de comunitat autònoma',
  `codi_acumulario_nacional` CHAR(6) NULL,
  PRIMARY KEY (`candidatura_id`),
  INDEX `idx_fk_eleccions_partits_eleccions` (`eleccio_id` ASC) VISIBLE,
  UNIQUE INDEX `uk_eleccions_partits` (`eleccio_id` ASC, `codi_candidatura` ASC) VISIBLE,
  CONSTRAINT `fk_eleccions_partits_eleccions`
    FOREIGN KEY (`eleccio_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`eleccions` (`eleccio_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`persones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`persones` (
  `persona_id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
  `nom` VARCHAR(30) NULL,
  `cog1` VARCHAR(30) NULL,
  `cog2` VARCHAR(30) NULL,
  `sexe` ENUM('M', 'F') NULL COMMENT 'M=Masculí, F=Femení',
  PRIMARY KEY (`persona_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`candidats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`candidats` (
  `candidat_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `candidatura_id` INT UNSIGNED NOT NULL,
  `persona_id` INT UNSIGNED NOT NULL,
  `provincia_id` TINYINT UNSIGNED NOT NULL,
  `num_ordre` TINYINT NULL COMMENT 'Num ordre del candidatdins la llista del partit dins de la circumpscripció que es presenta.',
  `tipus` ENUM('T', 'S') NULL COMMENT 'T=Titular, S=Suplent',
  PRIMARY KEY (`candidat_id`),
  INDEX `fk_candidats_provincies1_idx` (`provincia_id` ASC) VISIBLE,
  INDEX `fk_candidats_persones1_idx` (`persona_id` ASC) VISIBLE,
  INDEX `fk_candidats_candidatures1_idx` (`candidatura_id` ASC) VISIBLE,
  UNIQUE INDEX `uk_candidats_persona_cand` (`candidatura_id` ASC, `persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidats_provincies1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`provincies` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidats_persones1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`persones` (`persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidats_candidatures1`
    FOREIGN KEY (`candidatura_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`candidatures` (`candidatura_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`vots_candidatures_mun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`vots_candidatures_mun` (
  `eleccio_id` TINYINT UNSIGNED NOT NULL,
  `municipi_id` SMALLINT UNSIGNED NOT NULL,
  `candidatura_id` INT UNSIGNED NOT NULL,
  `vots` INT UNSIGNED NULL COMMENT 'Número de vots obtinguts per la candidatura',
  PRIMARY KEY (`eleccio_id`, `municipi_id`, `candidatura_id`),
  INDEX `fk_candidatures_municipis_candidatures1_idx` (`candidatura_id` ASC) VISIBLE,
  INDEX `fk_candidatures_municipis_eleccions_municipis1_idx` (`eleccio_id` ASC, `municipi_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidatures_municipis_candidatures1`
    FOREIGN KEY (`candidatura_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`candidatures` (`candidatura_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidatures_municipis_eleccions_municipis1`
    FOREIGN KEY (`eleccio_id` , `municipi_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`eleccions_municipis` (`eleccio_id` , `municipi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`vots_candidatures_prov`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`vots_candidatures_prov` (
  `provincia_id` TINYINT UNSIGNED NOT NULL,
  `candidatura_id` INT UNSIGNED NOT NULL,
  `vots` INT UNSIGNED NULL COMMENT 'Número de vots obtinguts per la candidatura',
  `candidats_obtinguts` SMALLINT UNSIGNED NULL COMMENT 'Número de candidats obtinguts per la candidatura',
  PRIMARY KEY (`provincia_id`, `candidatura_id`),
  INDEX `fk_candidatures_provincies_candidatures1_idx` (`candidatura_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidatures_provincies_provincies1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`provincies` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidatures_provincies_candidatures1`
    FOREIGN KEY (`candidatura_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`candidatures` (`candidatura_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eleccions_Generals_GrupB`.`vots_candidatures_ca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eleccions_Generals_GrupB`.`vots_candidatures_ca` (
  `comunitat_autonoma_id` TINYINT UNSIGNED NOT NULL,
  `candidatura_id` INT UNSIGNED NOT NULL,
  `vots` INT UNSIGNED NULL,
  PRIMARY KEY (`comunitat_autonoma_id`, `candidatura_id`),
  INDEX `fk_comunitats_autonomes_has_candidatures_candidatures1_idx` (`candidatura_id` ASC) VISIBLE,
  INDEX `fk_comunitats_autonomes_has_candidatures_comunitats_autonom_idx` (`comunitat_autonoma_id` ASC) VISIBLE,
  CONSTRAINT `fk_comunitats_autonomes_has_candidatures_comunitats_autonomes1`
    FOREIGN KEY (`comunitat_autonoma_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`comunitats_autonomes` (`comunitat_aut_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comunitats_autonomes_has_candidatures_candidatures1`
    FOREIGN KEY (`candidatura_id`)
    REFERENCES `Eleccions_Generals_GrupB`.`candidatures` (`candidatura_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;