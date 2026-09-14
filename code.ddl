-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-09-14 20:44:13 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE "." 
    ( 
     Producto_codigo_modelo1    VARCHAR2 (50 CHAR)  NOT NULL , 
     Detalle_Boleta_num_boleta  NUMBER (12)  NOT NULL , 
     Detalle_Boleta_id_producto NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE "." 
    ADD CONSTRAINT "._PK" PRIMARY KEY ( Producto_codigo_modelo1, Detalle_Boleta_num_boleta, Detalle_Boleta_id_producto ) ;

CREATE TABLE Boleta 
    ( 
     num_boleta                 NUMBER (12)  NOT NULL , 
     fecha_boleta               DATE  NOT NULL , 
     monto_total                NUMBER (12,2)  NOT NULL , 
     id_cliente                 NUMBER (10)  NOT NULL , 
     sigla_sucursal             VARCHAR2 (10 CHAR)  NOT NULL , 
     Detalle_Boleta_num_boleta  NUMBER (12)  NOT NULL , 
     Detalle_Boleta_id_producto NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE Boleta 
    ADD CONSTRAINT Boleta_PK PRIMARY KEY ( num_boleta, Detalle_Boleta_num_boleta, Detalle_Boleta_id_producto ) ;

CREATE TABLE Categoria 
    ( 
     id_categoria         NUMBER  NOT NULL , 
     nombre_categoria     VARCHAR2 (200 CHAR)  NOT NULL , 
     requiere_vencimiento CHAR (1 CHAR)  NOT NULL , 
     Categoria_ID         NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Categoria 
    ADD CONSTRAINT Categoria_PK PRIMARY KEY ( Categoria_ID ) ;

CREATE TABLE Cliente 
    ( 
     id_cliente NUMBER(10) CONSTRAINT pk_cliente PRIMARY KEY,
    nombre_completo VARCHAR2(150) NOT NULL,
    telefono VARCHAR2(20) NOT NULL,
    cod_comuna NUMBER(6) NOT NULL,

    CONSTRAINT fk_cliente_comuna
        FOREIGN KEY (cod_comuna)
        REFERENCES COMUNA(cod_comuna) 
    ) 
;
CREATE UNIQUE INDEX Cliente__IDX ON Cliente 
    ( 
     Boleta_num_boleta ASC , 
     Boleta_Detalle_Boleta_num_boleta ASC , 
     Boleta_Detalle_Boleta_id_producto ASC 
    ) 
;

CREATE TABLE Comuna 
    ( 
     cod_comuna              NUMBER  NOT NULL , 
     nom_comuna              VARCHAR2 (50 CHAR)  NOT NULL , 
     cod_region              NUMBER  NOT NULL , 
     Sucursal_sigla_sucursal VARCHAR2 (10 CHAR)  NOT NULL , 
     Sucursal_id_producto    NUMBER  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX Comuna__IDX ON Comuna 
    ( 
     Sucursal_sigla_sucursal ASC , 
     Sucursal_id_producto ASC 
    ) 
;

CREATE TABLE Detalle_Boleta 
    ( 
     num_boleta      NUMBER (12)  NOT NULL , 
     id_producto     NUMBER (10)  NOT NULL , 
     cantidad        NUMBER (10)  NOT NULL , 
     precio_unitario NUMBER (12,2)  NOT NULL 
    ) 
;

ALTER TABLE Detalle_Boleta 
    ADD CONSTRAINT Detalle_Boleta_PK PRIMARY KEY ( num_boleta, id_producto ) ;

CREATE TABLE Empresa 
    ( 
     rut_proveedor VARCHAR2(12) CONSTRAINT pk_empresa_proveedor PRIMARY KEY,
    razon_social VARCHAR2(150) NOT NULL,
    website VARCHAR2(200),

    CONSTRAINT fk_empresa_proveedor
        FOREIGN KEY (rut_proveedor)
        REFERENCES PROVEEDOR(rut_proveedor)
    ) 
;

ALTER TABLE Empresa 
    ADD CONSTRAINT Empresa_PK PRIMARY KEY ( rut_proveedor ) ;

ALTER TABLE Empresa 
    ADD CONSTRAINT Empresa_PKv1 UNIQUE ( rut_proveedor1 ) ;

CREATE TABLE Marca 
    ( 
     id_marca     NUMBER  NOT NULL , 
     nombre_marca VARCHAR2 (100 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE Marca 
    ADD CONSTRAINT Marca_PK PRIMARY KEY ( id_marca ) ;

CREATE TABLE Modelo 
    ( 
     id_marca           NUMBER  NOT NULL , 
     codigo_modelo      VARCHAR2 (50 CHAR)  NOT NULL , 
     descripcion_modelo VARCHAR2 (200 CHAR)  NOT NULL , 
     Marca_id_marca     NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Modelo 
    ADD CONSTRAINT Modelo_PK PRIMARY KEY ( codigo_modelo ) ;

CREATE TABLE Persona 
    ( 
     rut_proveedor    VARCHAR2 (12 CHAR)  NOT NULL , 
     rut_proveedor1   VARCHAR2 (12 CHAR)  NOT NULL , 
     nombres          VARCHAR2 (100 CHAR)  NOT NULL , 
     apellido_paterno VARCHAR2 (100 CHAR)  NOT NULL , 
     apellido_materno VARCHAR2 (100 CHAR) 
    ) 
;

ALTER TABLE Persona 
    ADD CONSTRAINT Persona_PK PRIMARY KEY ( rut_proveedor ) ;

ALTER TABLE Persona 
    ADD CONSTRAINT Persona_PKv1 UNIQUE ( rut_proveedor1 ) ;

CREATE TABLE Producto 
    ( 
     id_producto            NUMBER  NOT NULL , 
     codigo_barras          VARCHAR2 (50 CHAR)  NOT NULL , 
     nom_productos          VARCHAR2 (150 CHAR)  NOT NULL , 
     descripcion_producto   VARCHAR2 (250 CHAR) , 
     precio_venta           NUMBER (12,2)  NOT NULL , 
     vencimiento            DATE , 
     id_marca               NUMBER  NOT NULL , 
     codigo_modelo          VARCHAR2 (50 CHAR)  NOT NULL , 
     id_categoria           NUMBER  NOT NULL , 
     Modelo_codigo_modelo   VARCHAR2 (50 CHAR)  NOT NULL , 
     Categoria_Categoria_ID NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Producto 
    ADD CONSTRAINT Producto_PK PRIMARY KEY ( Modelo_codigo_modelo ) ;

CREATE TABLE Producto_Proveedor 
    ( 
     rut_proveedor  VARCHAR2 (12 CHAR)  NOT NULL , 
     rut_proveedor1 VARCHAR2 (12 CHAR)  NOT NULL , 
     id_procducto   NUMBER  NOT NULL , 
     precio_compra  NUMBER (12,2)  NOT NULL 
    ) 
;

ALTER TABLE Producto_Proveedor 
    ADD CONSTRAINT Producto_Proveedor_PK PRIMARY KEY ( rut_proveedor ) ;

ALTER TABLE Producto_Proveedor 
    ADD CONSTRAINT Producto_Proveedor_PKv1 UNIQUE ( rut_proveedor1 , id_procducto ) ;

CREATE TABLE Proveedor 
    ( 
     rut_proveedor VARCHAR2(12) CONSTRAINT pk_proveedor PRIMARY KEY,
    dv CHAR(1) NOT NULL,
    nombre VARCHAR2(150) NOT NULL,
    telefono VARCHAR2(20) NOT NULL,
    calle_direccion VARCHAR2(150) NOT NULL,
    numero_calle VARCHAR2(10) NOT NULL,
    email VARCHAR2(150) NOT NULL,
    tipo_proveedor CHAR(1) NOT NULL,

    CONSTRAINT ck_tipo_proveedor
        CHECK (tipo_proveedor IN ('E', 'P')) 
    ) 
;

ALTER TABLE Proveedor 
    ADD CONSTRAINT Proveedor_PK PRIMARY KEY ( rut_proveedor ) ;

CREATE TABLE Region 
    ( 
     cod_region NUMBER(3) CONSTRAINT pk_region PRIMARY KEY , 
     nom_region VARCHAR2 (100 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE Region 
    ADD CONSTRAINT Region_PK PRIMARY KEY ( cod_region ) ;

CREATE TABLE Relation_6 
    ( 
     Producto_Modelo_codigo_modelo VARCHAR2 (50 CHAR)  NOT NULL , 
     Proveedor_rut_proveedor       VARCHAR2 (12 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE Relation_6 
    ADD CONSTRAINT Relation_6_PK PRIMARY KEY ( Producto_Modelo_codigo_modelo, Proveedor_rut_proveedor ) ;

CREATE TABLE Relation_7 
    ( 
     Producto_Modelo_codigo_modelo VARCHAR2 (50 CHAR)  NOT NULL , 
     Stock_Sucursal_sigla_sucursal VARCHAR2 (10 CHAR)  NOT NULL , 
     Stock_Sucursal_id_producto    NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Relation_7 
    ADD CONSTRAINT Relation_7_PK PRIMARY KEY ( Producto_Modelo_codigo_modelo, Stock_Sucursal_sigla_sucursal, Stock_Sucursal_id_producto ) ;

CREATE TABLE Stock_Sucursal 
    ( 
     sigla_sucursal VARCHAR2 (10 CHAR)  NOT NULL , 
     id_producto    NUMBER  NOT NULL , 
     stock_actual   NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Stock_Sucursal 
    ADD CONSTRAINT Stock_Sucursal_PK PRIMARY KEY ( sigla_sucursal, id_producto ) ;

CREATE TABLE Sucursal 
    ( 
     sigla VARCHAR2(10) CONSTRAINT pk_sucursal PRIMARY KEY,
    nombre_sucursal VARCHAR2(100) NOT NULL,
    cod_comuna NUMBER(6) NOT NULL,

    CONSTRAINT fk_sucursal_comuna
        FOREIGN KEY (cod_comuna)
        REFERENCES COMUNA(cod_comuna)
    ) 
;

ALTER TABLE Sucursal 
    ADD CONSTRAINT Sucursal_PK PRIMARY KEY ( Stock_Sucursal_sigla_sucursal, Stock_Sucursal_id_producto ) ;

ALTER TABLE "." 
    ADD CONSTRAINT "._Detalle_Boleta_FK" FOREIGN KEY 
    ( 
     Detalle_Boleta_num_boleta,
     Detalle_Boleta_id_producto
    ) 
    REFERENCES Detalle_Boleta 
    ( 
     num_boleta,
     id_producto
    ) 
;

ALTER TABLE "." 
    ADD CONSTRAINT "._Producto_FK" FOREIGN KEY 
    ( 
     Producto_codigo_modelo1
    ) 
    REFERENCES Producto 
    ( 
     Modelo_codigo_modelo
    ) 
;

ALTER TABLE Boleta 
    ADD CONSTRAINT Boleta_Detalle_Boleta_FK FOREIGN KEY 
    ( 
     Detalle_Boleta_num_boleta,
     Detalle_Boleta_id_producto
    ) 
    REFERENCES Detalle_Boleta 
    ( 
     num_boleta,
     id_producto
    ) 
;

ALTER TABLE Cliente 
    ADD CONSTRAINT Cliente_Boleta_FK FOREIGN KEY 
    ( 
     Boleta_num_boleta,
     Boleta_Detalle_Boleta_num_boleta,
     Boleta_Detalle_Boleta_id_producto
    ) 
    REFERENCES Boleta 
    ( 
     num_boleta,
     Detalle_Boleta_num_boleta,
     Detalle_Boleta_id_producto
    ) 
;

ALTER TABLE Comuna 
    ADD CONSTRAINT Comuna_Sucursal_FK FOREIGN KEY 
    (cod_comuna NUMBER(6) CONSTRAINT pk_comuna PRIMARY KEY,
    nombre_comuna VARCHAR2(100) NOT NULL,
    cod_region NUMBER(3) NOT NULL,

    CONSTRAINT fk_comuna_region
        FOREIGN KEY (cod_region)
        REFERENCES REGION(cod_region)
    ) 
;

ALTER TABLE Empresa 
    ADD CONSTRAINT Empresa_Proveedor_FK FOREIGN KEY 
    ( 
     rut_proveedor
    ) 
    REFERENCES Proveedor 
    ( 
     rut_proveedor
    ) 
;

ALTER TABLE Modelo 
    ADD CONSTRAINT Modelo_Marca_FK FOREIGN KEY 
    ( 
     Marca_id_marca
    ) 
    REFERENCES Marca 
    ( 
     id_marca
    ) 
;

ALTER TABLE Persona 
    ADD CONSTRAINT Persona_Proveedor_FK FOREIGN KEY 
    ( 
     rut_proveedor
    ) 
    REFERENCES Proveedor 
    ( 
     rut_proveedor
    ) 
;

ALTER TABLE Producto 
    ADD CONSTRAINT Producto_Categoria_FK FOREIGN KEY 
    ( 
     Categoria_Categoria_ID
    ) 
    REFERENCES Categoria 
    ( 
     Categoria_ID
    ) 
;

ALTER TABLE Producto 
    ADD CONSTRAINT Producto_Modelo_FK FOREIGN KEY 
    ( 
     Modelo_codigo_modelo
    ) 
    REFERENCES Modelo 
    ( 
     codigo_modelo
    ) 
;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE Producto_Proveedor 
    ADD CONSTRAINT Producto_Proveedor_Proveedor_FK FOREIGN KEY 
    ( 
     rut_proveedor
    ) 
    REFERENCES Proveedor 
    ( 
     rut_proveedor
    ) 
;

-- Error - Foreign Key Region_Comuna_FK has no columns

ALTER TABLE Relation_6 
    ADD CONSTRAINT Relation_6_Producto_FK FOREIGN KEY 
    ( 
     Producto_Modelo_codigo_modelo
    ) 
    REFERENCES Producto 
    ( 
     Modelo_codigo_modelo
    ) 
;

ALTER TABLE Relation_6 
    ADD CONSTRAINT Relation_6_Proveedor_FK FOREIGN KEY 
    ( 
     Proveedor_rut_proveedor
    ) 
    REFERENCES Proveedor 
    ( 
     rut_proveedor
    ) 
;

ALTER TABLE Relation_7 
    ADD CONSTRAINT Relation_7_Producto_FK FOREIGN KEY 
    ( 
     Producto_Modelo_codigo_modelo
    ) 
    REFERENCES Producto 
    ( 
     Modelo_codigo_modelo
    ) 
;

ALTER TABLE Relation_7 
    ADD CONSTRAINT Relation_7_Stock_Sucursal_FK FOREIGN KEY 
    ( 
     Stock_Sucursal_sigla_sucursal,
     Stock_Sucursal_id_producto
    ) 
    REFERENCES Stock_Sucursal 
    ( 
     sigla_sucursal,
     id_producto
    ) 
;

ALTER TABLE Sucursal 
    ADD CONSTRAINT Sucursal_Stock_Sucursal_FK FOREIGN KEY 
    ( 
     Stock_Sucursal_sigla_sucursal,
     Stock_Sucursal_id_producto
    ) 
    REFERENCES Stock_Sucursal 
    ( 
     sigla_sucursal,
     id_producto
    ) 
;

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated

CREATE SEQUENCE Categoria_Categoria_ID_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Categoria_Categoria_ID_TRG 
BEFORE INSERT ON Categoria 
FOR EACH ROW 
WHEN (NEW.Categoria_ID IS NULL) 
BEGIN 
    :NEW.Categoria_ID := Categoria_Categoria_ID_SEQ.NEXTVAL; 
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             2
-- ALTER TABLE                             35
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   7
-- WARNINGS                                 0
