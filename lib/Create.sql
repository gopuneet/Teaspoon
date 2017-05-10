CREATE SCHEMA IF NOT EXISTS `cucumber_history` ;
USE `cucumber_history` ;
CREATE TABLE IF NOT EXISTS `cucumber_history`.`epoch_ids` ( `epoch` INT NOT NULL UNIQUE, `id` INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`)) ;
CREATE TABLE IF NOT EXISTS `cucumber_history`.`scenario_ids` ( `scenario` VARCHAR(255) NOT NULL UNIQUE, `id` INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`)) ;
CREATE TABLE IF NOT EXISTS `cucumber_history`.`branch_ids` ( `branch` VARCHAR(255) NOT NULL UNIQUE, `id` INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`)) ;
CREATE TABLE IF NOT EXISTS `cucumber_history`.`scenarios` ( `scenario_id` INT NOT NULL, `epoch_id` INT NOT NULL, `branch_id` INT NOT NULL, `success` TINYINT(1) NOT NULL, FOREIGN KEY (scenario_id) REFERENCES scenario_ids(id) ON DELETE CASCADE, FOREIGN KEY (epoch_id) REFERENCES epoch_ids(id) ON DELETE CASCADE, FOREIGN KEY (branch_id) REFERENCES branch_ids(id) ON DELETE CASCADE);