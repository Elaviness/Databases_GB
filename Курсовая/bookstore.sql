-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BookStore
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BookStore` ;

-- -----------------------------------------------------
-- Schema BookStore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BookStore` DEFAULT CHARACTER SET utf8 ;
USE `BookStore` ;

-- -----------------------------------------------------
-- Table `BookStore`.`books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`books` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`books` (
  `ISBN` VARCHAR(13) NOT NULL,
  `title` VARCHAR(45) NULL,
  `author` VARCHAR(45) NULL,
  `category` VARCHAR(45) NULL,
  `publish_year` YEAR(4) NULL,
  `price` DECIMAL(7,2) UNSIGNED NULL,
  `count` INT UNSIGNED NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`spaces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`spaces` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`spaces` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(100) NULL,
  `type` ENUM("store", "warehouse") NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`employees` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`employees` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NULL,
  `birth_date` DATE NULL,
  `position` VARCHAR(45) NULL,
  `phone_number` VARCHAR(11) NULL,
  `spaces_id` INT UNSIGNED NOT NULL,
  `salary` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employees_spaces1_idx` (`spaces_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_spaces1`
    FOREIGN KEY (`spaces_id`)
    REFERENCES `BookStore`.`spaces` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`clients` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`clients` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NULL,
  `birth_date` DATE NULL,
  `email` VARCHAR(100) NULL,
  `login` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `loyalty_card` VARCHAR(45) NULL,
  `discount_status` INT UNSIGNED NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`orders` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `clients_id` INT UNSIGNED NOT NULL,
  `employees_id` INT UNSIGNED NOT NULL,
  `order_date` DATETIME NULL DEFAULT NOW(),
  `delivery_address` VARCHAR(100) NULL,
  `delivery_date` DATE NULL,
  `delivery_cost` DECIMAL(6,2) NULL,
  `order_cost` DECIMAL(7,2) NULL,
  `delivery_status` ENUM("accepted", "paid", "in_delivery", "delivered") NULL,
  `total_count` INT NULL,
  `total_price` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_clients1_idx` (`clients_id` ASC) VISIBLE,
  INDEX `fk_orders_employees1_idx` (`employees_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `BookStore`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`employees_id`)
    REFERENCES `BookStore`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`cheque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`cheque` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`cheque` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purshase_time` DATE NULL,
  `orders_id` INT UNSIGNED NOT NULL,
  `tax` TINYINT(3) NULL DEFAULT 10,
  PRIMARY KEY (`id`),
  INDEX `fk_cheque_orders_idx` (`orders_id` ASC) VISIBLE,
  CONSTRAINT `fk_cheque_orders`
    FOREIGN KEY (`orders_id`)
    REFERENCES `BookStore`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`requests` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`requests` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `spaces_id` INT UNSIGNED NOT NULL,
  `request_date` DATE NULL,
  `complete_date` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_requests_spaces1_idx` (`spaces_id` ASC) VISIBLE,
  CONSTRAINT `fk_requests_spaces1`
    FOREIGN KEY (`spaces_id`)
    REFERENCES `BookStore`.`spaces` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`supplies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`supplies` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`supplies` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `supplier` VARCHAR(100) NULL,
  `spaces_id` INT UNSIGNED NOT NULL,
  `cost` DECIMAL(10,2) NULL,
  `date` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_supplies_spaces1_idx` (`spaces_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplies_spaces1`
    FOREIGN KEY (`spaces_id`)
    REFERENCES `BookStore`.`spaces` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`books_has_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`books_has_orders` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`books_has_orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `books_ISBN` VARCHAR(13) NOT NULL,
  `orders_id` INT UNSIGNED NOT NULL,
  `book_count` INT UNSIGNED NULL,
  `position_cost` DECIMAL(7,2) NULL,
  INDEX `fk_books_has_orders_orders1_idx` (`orders_id` ASC) VISIBLE,
  INDEX `fk_books_has_orders_books1_idx` (`books_ISBN` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_books_has_orders_books1`
    FOREIGN KEY (`books_ISBN`)
    REFERENCES `BookStore`.`books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_orders_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `BookStore`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`employees_has_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`employees_has_requests` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`employees_has_requests` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `employees_id` INT UNSIGNED NOT NULL,
  `requests_id` INT UNSIGNED NOT NULL,
  INDEX `fk_employees_has_requests_requests1_idx` (`requests_id` ASC) VISIBLE,
  INDEX `fk_employees_has_requests_employees1_idx` (`employees_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_employees_has_requests_employees1`
    FOREIGN KEY (`employees_id`)
    REFERENCES `BookStore`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_has_requests_requests1`
    FOREIGN KEY (`requests_id`)
    REFERENCES `BookStore`.`requests` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookStore`.`spaces_has_books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookStore`.`spaces_has_books` ;

CREATE TABLE IF NOT EXISTS `BookStore`.`spaces_has_books` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `spaces_id` INT UNSIGNED NOT NULL,
  `books_ISBN` VARCHAR(13) NOT NULL,
  `count_in_space` INT NULL,
  INDEX `fk_spaces_has_books_books1_idx` (`books_ISBN` ASC) VISIBLE,
  INDEX `fk_spaces_has_books_spaces1_idx` (`spaces_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_spaces_has_books_spaces1`
    FOREIGN KEY (`spaces_id`)
    REFERENCES `BookStore`.`spaces` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_spaces_has_books_books1`
    FOREIGN KEY (`books_ISBN`)
    REFERENCES `BookStore`.`books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
