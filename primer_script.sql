-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Tienda
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS tienda DEFAULT CHARACTER SET utf8 ;
USE tienda ;

-- Borrado de las tablas en cascada
DROP TABLE product_has_bill;
DROP TABLE seller;
DROP TABLE suplier;
DROP TABLE customer;
DROP TABLE document_type;
DROP TABLE bill;
DROP TABLE product;

-- -----------------------------------------------------
-- Table product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
  pro_id INT NOT NULL AUTO_INCREMENT,
  pro_price DOUBLE NOT NULL,
  pro_name VARCHAR(45) NOT NULL,
  pro_created_at DATETIME NOT NULL,
  pro_updated_at DATETIME NULL,
  pro_deleted_at DATETIME NULL,
  PRIMARY KEY (pro_id)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table bill
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS bill (
  bil_id INT NOT NULL,
  bil_value VARCHAR(45) NOT NULL,
  bil_created_at DATETIME NOT NULL,
  bul_deleted_at DATETIME NULL,
  PRIMARY KEY (bil_id)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table document_type
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS document_type (
  doc_id INT NOT NULL AUTO_INCREMENT,
  doc_type VARCHAR(45) NOT NULL,
  doc_created_at DATETIME NOT NULL,
  doc_updated_at DATETIME NULL,
  doc_deleted_at DATETIME NULL,
  PRIMARY KEY (doc_id)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table customer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer (
  cus_id INT NOT NULL AUTO_INCREMENT,
  bill_bil_id INT NOT NULL,
  document_type_doc_id INT NOT NULL,
  cus_document VARCHAR(15) NOT NULL,
  cus_created_at DATETIME NOT NULL,
  cus_updated_at DATETIME NULL,
  cus_deleted_at DATETIME NULL,
  PRIMARY KEY (cus_id),
  UNIQUE INDEX cus_document_UNIQUE (cus_document ASC, document_type_doc_id ASC) VISIBLE,
  INDEX fk_customer_bill1_idx (bill_bil_id ASC) VISIBLE,
  INDEX fk_customer_document_type1_idx (document_type_doc_id ASC) VISIBLE,
  CONSTRAINT fk_customer_bill1
    FOREIGN KEY (bill_bil_id)
    REFERENCES bill (bil_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_customer_document_type1
    FOREIGN KEY (document_type_doc_id)
    REFERENCES document_type (doc_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table suplier
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS suplier (
  sup_id INT NOT NULL AUTO_INCREMENT,
  product_pro_id INT NOT NULL,
  sup_name VARCHAR(45) NOT NULL,
  sup_phone VARCHAR(15) NOT NULL,
  sup_email VARCHAR(45) NULL,
  sup_created_at DATETIME NOT NULL,
  sup_updated_at DATETIME NULL,
  sup_deleted_at DATETIME NULL,
  PRIMARY KEY (sup_id),
  INDEX fk_suplier_product_idx (product_pro_id ASC) VISIBLE,
  CONSTRAINT fk_suplier_product
    FOREIGN KEY (product_pro_id)
    REFERENCES product (pro_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seller (
  sel_id INT NOT NULL AUTO_INCREMENT,
  bill_bil_id INT NOT NULL,
  sel_name VARCHAR(45) NOT NULL,
  sel_created_at DATETIME NOT NULL,
  sel_updated_at DATETIME NULL,
  sel_deleted_at DATETIME NULL,
  PRIMARY KEY (sel_id),
  INDEX fk_seller_bill1_idx (bill_bil_id ASC) VISIBLE,
  CONSTRAINT fk_seller_bill1
    FOREIGN KEY (bill_bil_id)
    REFERENCES bill (bil_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_has_bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_has_bill (
  product_pro_id INT NOT NULL,
  bill_bil_id INT NOT NULL,
  PRIMARY KEY (product_pro_id, bill_bil_id),
  INDEX fk_product_has_bill_bill1_idx (bill_bil_id ASC) VISIBLE,
  INDEX fk_product_has_bill_product1_idx (product_pro_id ASC) VISIBLE,
  CONSTRAINT fk_product_has_bill_product1
    FOREIGN KEY (product_pro_id)
    REFERENCES product (pro_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_bill_bill1
    FOREIGN KEY (bill_bil_id)
    REFERENCES bill (bil_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Insercion de datos ala BD
-- -----------------------------------------------------

-- Insercion a la tabla producto

INSERT INTO product (pro_price, pro_name, pro_created_at)
VALUES (500, 'HUEVOS', NOW());

INSERT INTO product (pro_price, pro_name, pro_created_at)
VALUES (5000, 'PAPA', NOW());

INSERT INTO product (pro_price, pro_name, pro_created_at)
VALUES (3400, 'GASEOSA', NOW());

-- Insercion a la tabla factura

INSERT INTO bill (bil_value, bil_created_at)
VALUES (54000, NOW());

INSERT INTO bill (bil_value, bil_created_at)
VALUES (105000, NOW());

INSERT INTO bill (bil_value, bil_created_at)
VALUES (30460, NOW());

-- Insercion a la tabla Tipo de documento

INSERT INTO document_type (doc_type, doc_created_at)
VALUES ('CC', NOW());

INSERT INTO document_type (doc_type, doc_created_at)
VALUES ('CE', NOW());

INSERT INTO document_type (doc_type, doc_created_at)
VALUES ('TI', NOW());

-- Insercion a la tabla Cliente

INSERT INTO customer (bill_bil_id, document_type_doc_id, cus_document, cus_created_at)
VALUES (1, 1, 123456, NOW());

INSERT INTO customer (bill_bil_id, document_type_doc_id, cus_document, cus_created_at)
VALUES (2, 2, 123456, NOW());

INSERT INTO customer (bill_bil_id, document_type_doc_id, cus_document, cus_created_at)
VALUES (3, 3, 123456, NOW());

-- Insercion a la tabla Proveedor

INSERT INTO suplier (product_pro_id, sup_name, sup_phone, sup_email, sup_created_at)
VALUES (1, 'AVINAL', '1456789', '', NOW());

INSERT INTO suplier (product_pro_id, sup_name, sup_phone, sup_email, sup_created_at)
VALUES (2, 'PAPAS JOSE LUIS', '1456775', 'papasjose123@gmail.com', NOW());

INSERT INTO suplier (product_pro_id, sup_name, sup_phone, sup_email, sup_created_at)
VALUES (3, 'POSTOBON', '1456654', '', NOW());

-- Insercion a la tabla Vendedor

INSERT INTO seller (bill_bil_id, sel_name, sel_created_at)
VALUES ('1', 'JOSE', NOW());

INSERT INTO seller (bill_bil_id, sel_name, sel_created_at)
VALUES ('2', 'JOSE', NOW());

INSERT INTO seller (bill_bil_id, sel_name, sel_created_at)
VALUES ('3', 'JOSE', NOW());

-- Insercion a la tabla Producto_Factura

INSERT INTO product_has_bill (product_pro_id, bill_bil_id)
VALUES (1,1);

INSERT INTO product_has_bill (product_pro_id, bill_bil_id)
VALUES (2,1);

INSERT INTO product_has_bill (product_pro_id, bill_bil_id)
VALUES (1,2);

INSERT INTO product_has_bill (product_pro_id, bill_bil_id)
VALUES (3,3);

-- Borrado Fisico

DELETE FROM product
WHERE pro_id = 4;

DELETE FROM suplier
WHERE sup_name = 'GRANJA DON PACHO';

-- Borrado Logico

UPDATE document_type
SET doc_deleted_at = NOW()
WHERE doc_type = 'CE';

UPDATE product
SET pro_deleted_at = NOW()
WHERE pro_name = 'GASEOSA';

-- Modificacion de tres productos en su nombre y proveedor que los provee

UPDATE product
SET pro_name = 'GASEOSA',
    pro_updated_at = NOW()
WHERE pro_id = 1;

UPDATE suplier
SET product_pro_id = 1,
    sup_updated_at = NOW()
WHERE sup_name = 'POSTOBON';

UPDATE product
SET pro_name = 'HUEVOS',
    pro_updated_at = NOW()
WHERE pro_id = 2;

UPDATE suplier
SET product_pro_id = 2,
    sup_updated_at = NOW()
WHERE sup_name = 'AVINAL';

UPDATE product
SET pro_name = 'PAPAS',
    pro_updated_at = NOW()
WHERE pro_id = 3;

UPDATE suplier
SET product_pro_id = 3,
    sup_updated_at = NOW()
WHERE sup_name = 'PAPAS JOSE LUIS';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
