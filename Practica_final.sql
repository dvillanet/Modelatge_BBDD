-- MySQL Script generated by MySQL Workbench
-- Fri Mar 27 22:37:34 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`Contactes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Contactes` (
  `Contactes_id` INT NOT NULL AUTO_INCREMENT,
  `Contactes_adreca` VARCHAR(200) NULL,
  `Contactes_telefon` VARCHAR(45) NULL,
  `Contactes_email` VARCHAR(45) NULL,
  `Contactes_fax` VARCHAR(45) NULL,
  `Contactes_nif` VARCHAR(45) NULL,
  `Contactes_nom` VARCHAR(45) NULL,
  `Contactes_cognom` VARCHAR(45) NULL,
  PRIMARY KEY (`Contactes_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Proveidors` (
  `Proveidors_id` INT NOT NULL AUTO_INCREMENT,
  `Contactes_Contactes_id` INT NOT NULL,
  `Proveidors_nom` VARCHAR(45) NULL,
  PRIMARY KEY (`Proveidors_id`),
  INDEX `fk_Proveidors_Contactes1_idx` (`Contactes_Contactes_id` ASC),
  CONSTRAINT `fk_Proveidors_Contactes1`
    FOREIGN KEY (`Contactes_Contactes_id`)
    REFERENCES `Optica`.`Contactes` (`Contactes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Marques` (
  `Marques_id` INT NOT NULL AUTO_INCREMENT,
  `Marques_nom` VARCHAR(45) NULL,
  `Proveidors_Proveidors_id` INT NOT NULL,
  PRIMARY KEY (`Marques_id`),
  INDEX `fk_Marques_Proveidors1_idx` (`Proveidors_Proveidors_id` ASC),
  CONSTRAINT `fk_Marques_Proveidors1`
    FOREIGN KEY (`Proveidors_Proveidors_id`)
    REFERENCES `Optica`.`Proveidors` (`Proveidors_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Clients` (
  `Clients_id` INT NOT NULL AUTO_INCREMENT,
  `Recomanacio` VARCHAR(45) NULL,
  `Contactes_Contactes_id` INT NOT NULL,
  `Clients_creacio` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Clients_id`),
  INDEX `fk_Clients_Contactes1_idx` (`Contactes_Contactes_id` ASC),
  CONSTRAINT `fk_Clients_Contactes1`
    FOREIGN KEY (`Contactes_Contactes_id`)
    REFERENCES `Optica`.`Contactes` (`Contactes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Graduacions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Graduacions` (
  `Graduacions_id` INT NOT NULL AUTO_INCREMENT,
  `Graduacions_valor` FLOAT NULL,
  PRIMARY KEY (`Graduacions_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Colors_vidre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Colors_vidre` (
  `Colors_vidre_id` INT NOT NULL AUTO_INCREMENT,
  `Colors_vidre_nom` VARCHAR(45) NULL,
  PRIMARY KEY (`Colors_vidre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Vidres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Vidres` (
  `Vidres_id` INT NOT NULL AUTO_INCREMENT,
  `Graduacions_Graduacions_id` INT NOT NULL,
  `Colors_vidre_Colors_vidre_id` INT NOT NULL,
  PRIMARY KEY (`Vidres_id`),
  INDEX `fk_Vidres_Graduacions1_idx` (`Graduacions_Graduacions_id` ASC),
  INDEX `fk_Vidres_Colors_vidre1_idx` (`Colors_vidre_Colors_vidre_id` ASC),
  CONSTRAINT `fk_Vidres_Graduacions1`
    FOREIGN KEY (`Graduacions_Graduacions_id`)
    REFERENCES `Optica`.`Graduacions` (`Graduacions_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Vidres_Colors_vidre1`
    FOREIGN KEY (`Colors_vidre_Colors_vidre_id`)
    REFERENCES `Optica`.`Colors_vidre` (`Colors_vidre_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Ulleres` (
  `Ulleres_id` INT NOT NULL AUTO_INCREMENT,
  `Ulleres_color_montura` VARCHAR(45) NULL,
  `Ulleres_preu` DECIMAL(8) NULL,
  `Marques_Marques_id` INT NOT NULL,
  `Vidres_Vidres_L` INT NOT NULL,
  `Vidres_Vidres_R` INT NOT NULL,
  `Ulleres_stock` INT NULL,
  PRIMARY KEY (`Ulleres_id`),
  INDEX `fk_Ulleres_Marques1_idx` (`Marques_Marques_id` ASC),
  INDEX `fk_Ulleres_Vidres1_idx` (`Vidres_Vidres_L` ASC),
  INDEX `fk_Ulleres_Vidres2_idx` (`Vidres_Vidres_R` ASC),
  CONSTRAINT `fk_Ulleres_Marques1`
    FOREIGN KEY (`Marques_Marques_id`)
    REFERENCES `Optica`.`Marques` (`Marques_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ulleres_Vidres1`
    FOREIGN KEY (`Vidres_Vidres_L`)
    REFERENCES `Optica`.`Vidres` (`Vidres_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ulleres_Vidres2`
    FOREIGN KEY (`Vidres_Vidres_R`)
    REFERENCES `Optica`.`Vidres` (`Vidres_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Empleats` (
  `Empleats_id` INT NOT NULL AUTO_INCREMENT,
  `Contactes_Contactes_id` INT NOT NULL,
  PRIMARY KEY (`Empleats_id`),
  INDEX `fk_Empleats_Contactes_idx` (`Contactes_Contactes_id` ASC),
  CONSTRAINT `fk_Empleats_Contactes`
    FOREIGN KEY (`Contactes_Contactes_id`)
    REFERENCES `Optica`.`Contactes` (`Contactes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Facturas` (
  `Facturas_id` INT NOT NULL AUTO_INCREMENT,
  `Clients_Clients_id` INT NOT NULL,
  `Empleats_Empleats_id` INT NOT NULL,
  PRIMARY KEY (`Facturas_id`),
  INDEX `fk_Facturas_Clients1_idx` (`Clients_Clients_id` ASC),
  INDEX `fk_Facturas_Empleats1_idx` (`Empleats_Empleats_id` ASC),
  CONSTRAINT `fk_Facturas_Clients1`
    FOREIGN KEY (`Clients_Clients_id`)
    REFERENCES `Optica`.`Clients` (`Clients_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Facturas_Empleats1`
    FOREIGN KEY (`Empleats_Empleats_id`)
    REFERENCES `Optica`.`Empleats` (`Empleats_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Lineas_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Lineas_factura` (
  `Lineas_factura_id` INT NOT NULL AUTO_INCREMENT,
  `Facturas_Facturas_id` INT NOT NULL,
  `Ulleres_Ulleres_id` INT NOT NULL,
  `Lineas_factura_unitats` INT NULL,
  PRIMARY KEY (`Lineas_factura_id`),
  INDEX `fk_Lineas_factura_Facturas1_idx` (`Facturas_Facturas_id` ASC),
  INDEX `fk_Lineas_factura_Ulleres1_idx` (`Ulleres_Ulleres_id` ASC),
  CONSTRAINT `fk_Lineas_factura_Facturas1`
    FOREIGN KEY (`Facturas_Facturas_id`)
    REFERENCES `Optica`.`Facturas` (`Facturas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Lineas_factura_Ulleres1`
    FOREIGN KEY (`Ulleres_Ulleres_id`)
    REFERENCES `Optica`.`Ulleres` (`Ulleres_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
