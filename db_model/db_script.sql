-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cv-maker
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cv-maker` ;

-- -----------------------------------------------------
-- Schema cv-maker
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cv-maker` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `cv-maker` ;

-- -----------------------------------------------------
-- Table `cv-maker`.`cv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`cv` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`cv` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cvName` VARCHAR(80) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastChange` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`country` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`country` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`address` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `addressName` VARCHAR(80) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `lastChange` TIMESTAMP NULL DEFAULT NULL,
  `idCountry` INT UNSIGNED NOT NULL,
  `address` TINYTEXT NOT NULL,
  `number` VARCHAR(80) NOT NULL,
  `complement` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Address_idCountry_idx` (`idCountry` ASC),
  CONSTRAINT `fk_address_idCountry`
    FOREIGN KEY (`idCountry`)
    REFERENCES `cv-maker`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`phone_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`phone_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`phone_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`cv_header`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`cv_header` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`cv_header` (
  `idCv` INT UNSIGNED NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `idAddress` INT UNSIGNED NOT NULL,
  `email` TINYTEXT NOT NULL,
  `siteUrl` TINYTEXT NULL,
  `phone1` VARCHAR(50) NULL,
  `idTypePhone1` INT UNSIGNED NULL,
  `phone2` VARCHAR(50) NULL,
  `idTypePhone2` INT UNSIGNED NULL,
  `title` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idCv`),
  INDEX `fk_cv_header_idAddress_idx` (`idAddress` ASC),
  INDEX `fk_cv_header_idTypePhone1_idx` (`idTypePhone1` ASC),
  INDEX `fk_cv_header_idTypePhone2_idx` (`idTypePhone2` ASC),
  CONSTRAINT `fk_cv_header_idCv`
    FOREIGN KEY (`idCv`)
    REFERENCES `cv-maker`.`cv` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_header_idAddress`
    FOREIGN KEY (`idAddress`)
    REFERENCES `cv-maker`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_header_idTypePhone1`
    FOREIGN KEY (`idTypePhone1`)
    REFERENCES `cv-maker`.`phone_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_header_idTypePhone2`
    FOREIGN KEY (`idTypePhone2`)
    REFERENCES `cv-maker`.`phone_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`state` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`state` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCountry` INT UNSIGNED NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_state_idCountry_idx` (`idCountry` ASC),
  CONSTRAINT `fk_state_idCountry`
    FOREIGN KEY (`idCountry`)
    REFERENCES `cv-maker`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`city` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`city` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCountry` INT UNSIGNED NULL,
  `idState` INT UNSIGNED NULL,
  `name` VARCHAR(200) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_city_idCountry_idx` (`idCountry` ASC),
  INDEX `fk_city_idState_idx` (`idState` ASC),
  CONSTRAINT `fk_city_idCountry`
    FOREIGN KEY (`idCountry`)
    REFERENCES `cv-maker`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_city_idState`
    FOREIGN KEY (`idState`)
    REFERENCES `cv-maker`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`address_city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`address_city` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`address_city` (
  `idAddress` INT UNSIGNED NOT NULL,
  `idCity` INT UNSIGNED NOT NULL,
  `cityName` VARCHAR(200) NULL,
  PRIMARY KEY (`idAddress`),
  INDEX `fk_address_city_idCity_idx` (`idCity` ASC),
  CONSTRAINT `fk_address_city_idAddress`
    FOREIGN KEY (`idAddress`)
    REFERENCES `cv-maker`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_city_idCity`
    FOREIGN KEY (`idCity`)
    REFERENCES `cv-maker`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`address_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`address_state` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`address_state` (
  `idAddress` INT UNSIGNED NOT NULL,
  `idState` INT UNSIGNED NOT NULL,
  `sateName` VARCHAR(200) NULL,
  PRIMARY KEY (`idAddress`),
  INDEX `fk_address_state_idState_idx` (`idState` ASC),
  CONSTRAINT `fk_address_state_idAddress`
    FOREIGN KEY (`idAddress`)
    REFERENCES `cv-maker`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_state_idState`
    FOREIGN KEY (`idState`)
    REFERENCES `cv-maker`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`experience`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`experience` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`experience` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCompany` INT NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NULL,
  `jobTitle` VARCHAR(200) NOT NULL,
  `description` TEXT NOT NULL,
  `idCv` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_experiences_idCv_idx` (`idCv` ASC),
  CONSTRAINT `fk_experiences_idCv`
    FOREIGN KEY (`idCv`)
    REFERENCES `cv-maker`.`cv` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`skill` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`skill` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `skillName` VARCHAR(200) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`skill_level`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`skill_level` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`skill_level` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `displayedText` VARCHAR(45) NOT NULL,
  `fillPercentage` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`cv_skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`cv_skill` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`cv_skill` (
  `idCv` INT UNSIGNED NOT NULL,
  `idSkill` INT UNSIGNED NOT NULL,
  `idSkillLevel` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idCv`, `idSkill`, `idSkillLevel`),
  INDEX `fk_cv_skill_idSkill_idx` (`idSkill` ASC),
  INDEX `fk_cv_skill_idSkillLevel_idx` (`idSkillLevel` ASC),
  CONSTRAINT `fk_cv_skill_idCv`
    FOREIGN KEY (`idCv`)
    REFERENCES `cv-maker`.`cv` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_skill_idSkill`
    FOREIGN KEY (`idSkill`)
    REFERENCES `cv-maker`.`skill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cv_skill_idSkillLevel`
    FOREIGN KEY (`idSkillLevel`)
    REFERENCES `cv-maker`.`skill_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cv-maker`.`cv_applicant_description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cv-maker`.`cv_applicant_description` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cv-maker`.`cv_applicant_description` (
  `idCv` INT UNSIGNED NOT NULL,
  `description` TINYTEXT NOT NULL,
  PRIMARY KEY (`idCv`),
  CONSTRAINT `fk_cv_applicant_description_idCv`
    FOREIGN KEY (`idCv`)
    REFERENCES `cv-maker`.`cv` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
