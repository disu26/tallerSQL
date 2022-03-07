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

-- Obtener los productos vendidos digitando tipo de documento y numero de documento.

SELECT p.pro_id, p.pro_name, p.pro_price
FROM product AS p
        INNER JOIN product_has_bill phb on p.pro_id = phb.product_pro_id
        INNER JOIN bill b on phb.bill_bil_id = b.bil_id
    INNER JOIN customer c on b.bil_id = c.bill_bil_id
    INNER JOIN document_type dt on c.document_type_doc_id = dt.doc_id
WHERE dt.doc_type = 'CC' AND c.cus_document = '123456';

-- Consultar productos por medio del nombre, el cual debe mostrar quien o quienes han sido sus proveedores.

SELECT s.sup_id, s.sup_name, s.sup_phone, s.sup_email
FROM product AS p
    INNER JOIN suplier s on p.pro_id = s.product_pro_id
WHERE p.pro_name = 'PAPAS';

-- Consulta que me permita ver que producto ha sido el mas vendido y en que cantidades de mayor a menor.

SELECT p.pro_id, p.pro_name, p.pro_price, COUNT(phb.product_pro_id) AS total
FROM product AS p
    INNER JOIN product_has_bill phb on p.pro_id = phb.product_pro_id
GROUP BY phb.product_pro_id
ORDER BY total DESC;