


CREATE TABLE comuna (
    id_comuna     NUMBER(10) NOT NULL,
    nombre_comuna VARCHAR2(100) NOT NULL,
    estado        NUMBER NOT NULL,
    id_region     NUMBER(10) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

CREATE TABLE deporte (
    id_deporte     NUMBER NOT NULL,
    nombre_deporte VARCHAR2(100) NOT NULL,
    estado         NUMBER NOT NULL
);

ALTER TABLE deporte ADD CONSTRAINT deporte_pk PRIMARY KEY ( id_deporte );

CREATE TABLE deportes_escuela (
    id_escuela NUMBER NOT NULL,
    id_deporte           NUMBER NOT NULL,
    estado                       NUMBER
);

ALTER TABLE deportes_escuela ADD CONSTRAINT deportes_escuela_pk PRIMARY KEY ( id_escuela,
                                                                              id_deporte );

CREATE TABLE direccion (
    id_direccion NUMBER(10) NOT NULL,
    calle        VARCHAR2(100) NOT NULL,
    numero       VARCHAR2(20) NOT NULL,
    referencia   VARCHAR2(50),
    estado       NUMBER NOT NULL,
    id_comuna    NUMBER(10) NOT NULL
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_direccion );

CREATE TABLE equipamiento (
    id_equipamiento      NUMBER(10) NOT NULL,
    marca                VARCHAR2(100) NOT NULL,
    modelo               VARCHAR2(100) NOT NULL,
    fecha_adquisicion    TIMESTAMP WITH TIME ZONE NOT NULL,
    fecha_eliminacion    TIMESTAMP WITH LOCAL TIME ZONE,
    estado               NUMBER NOT NULL,
    costo_adquision      NUMBER(10, 2) NOT NULL,
    id_tipo_equipamiento NUMBER(10) NOT NULL,
    id_escuela           NUMBER NOT NULL,
    numero_serie         VARCHAR2(100)
);

ALTER TABLE equipamiento ADD CONSTRAINT equipamiento_pk PRIMARY KEY ( id_equipamiento );

CREATE TABLE escuela_deportiva (
    id_escuela     NUMBER NOT NULL,
    nombre_escuela VARCHAR2(100) NOT NULL,
    estado         NUMBER NOT NULL
);

ALTER TABLE escuela_deportiva ADD CONSTRAINT escuela_deportiva_pk PRIMARY KEY ( id_escuela );

CREATE TABLE insumo (
    id_insumo       NUMBER(10) NOT NULL,
    marca           VARCHAR2(100),
    modelo          VARCHAR2(100),
    fecha_adquision DATE NOT NULL,
    costo_adquision NUMBER(10, 2),
    estado          NUMBER NOT NULL,
    id_equipamiento NUMBER(10) NOT NULL,
    id_tipo_insumo  NUMBER(10) NOT NULL,
    numero_serie    VARCHAR2(100)
);

ALTER TABLE insumo ADD CONSTRAINT insumo_pk PRIMARY KEY ( id_insumo );

CREATE TABLE insumo_tipo_equipamiento ( 
    id_tipo_equipamiento NUMBER(10) NOT NULL,
    id_tipo_insumo             NUMBER(10) NOT NULL,
    estado                                 NUMBER(1) NOT NULL
);

ALTER TABLE insumo_tipo_equipamiento ADD CONSTRAINT insumo_tipo_equipamiento_pk PRIMARY KEY ( id_tipo_equipamiento,
                                                                                              id_tipo_insumo );

CREATE TABLE pais (
    id_pais     NUMBER(10) NOT NULL,
    nombre_pais VARCHAR2(100) NOT NULL,
    estado      NUMBER NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE persona (
    id_persona             NUMBER NOT NULL,
    identificador_nacional VARCHAR2(10) NOT NULL,
    nombres                VARCHAR2(100) NOT NULL,
    apellidos              VARCHAR2(100),
    telefono               VARCHAR2(20),
    email                  VARCHAR2(100),
    estado                 NUMBER NOT NULL,
    id_pais                NUMBER(10) NOT NULL
);

ALTER TABLE persona ADD CONSTRAINT persona_pk PRIMARY KEY ( id_persona );

CREATE TABLE personal (
    fecha_contratacion   DATE NOT NULL,
    fecha_desvinculacion DATE,
    estado               NUMBER NOT NULL,
    id_escuela           NUMBER NOT NULL,
    id_persona           NUMBER NOT NULL
);

ALTER TABLE personal ADD CONSTRAINT personal_pk PRIMARY KEY ( id_escuela,
                                                              id_persona );

CREATE TABLE profesion (
    id_profesion     NUMBER(10) NOT NULL,
    nombre_profesion VARCHAR2(100) NOT NULL,
    estado           NUMBER NOT NULL
);

ALTER TABLE profesion ADD CONSTRAINT profesion_pk PRIMARY KEY ( id_profesion );

CREATE TABLE profesion_persona (
    id_persona     NUMBER NOT NULL,
    id_profesion NUMBER(10) NOT NULL,
    estado                 NUMBER NOT NULL,
    fecha_titulacion       DATE NOT NULL
);

ALTER TABLE profesion_persona ADD CONSTRAINT profesion_persona_pk PRIMARY KEY ( id_persona,
                                                                                id_profesion );

CREATE TABLE region (
    id_region     NUMBER(10) NOT NULL,
    nombre_region VARCHAR2(100) NOT NULL,
    estado        NUMBER NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

CREATE TABLE remuneraciones (
    agno          NUMBER(4) NOT NULL,
    mes           NUMBER(2) NOT NULL,
    sueldo_pagado NUMBER(10, 2) NOT NULL,
    id_escuela    NUMBER NOT NULL,
    id_persona    NUMBER NOT NULL
);

ALTER TABLE remuneraciones
    ADD CONSTRAINT remuneraciones_pk PRIMARY KEY ( mes,
                                                   agno,
                                                   id_escuela,
                                                   id_persona );

CREATE TABLE sede (
    id_escuela NUMBER NOT NULL,
    id_direccion       NUMBER(10) NOT NULL,
    es_principal                 NUMBER NOT NULL,
    propio_arriendo              NUMBER NOT NULL,
    costo_adquision              NUMBER(10, 2),
    costo_arriendo_mensual       NUMBER(10, 2)
);

ALTER TABLE sede ADD CONSTRAINT sede_pk PRIMARY KEY ( id_escuela,
                                                      id_direccion );

CREATE TABLE tipo_equipamiento (
    id_tipo_equipamiento     NUMBER(10) NOT NULL,
    nombre_tipo_equipamiento VARCHAR2(100) NOT NULL,
    estado                   NUMBER NOT NULL
);

ALTER TABLE tipo_equipamiento ADD CONSTRAINT tipo_equipamiento_pk PRIMARY KEY ( id_tipo_equipamiento );

CREATE TABLE tipo_insumo (
    id_tipo_insumo     NUMBER(10) NOT NULL,
    nombre_tipo_insumo VARCHAR2(100) NOT NULL,
    estado             NUMBER NOT NULL
);

ALTER TABLE tipo_insumo ADD CONSTRAINT tipo_insumo_pk PRIMARY KEY ( id_tipo_insumo );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_region_fk FOREIGN KEY ( id_region )
        REFERENCES region ( id_region );

ALTER TABLE deportes_escuela
    ADD CONSTRAINT deportes_escuela_deporte_fk FOREIGN KEY ( id_deporte )
        REFERENCES deporte ( id_deporte );


ALTER TABLE deportes_escuela
    ADD CONSTRAINT deportes_escuela_deportiva_fk FOREIGN KEY ( id_escuela )
        REFERENCES escuela_deportiva ( id_escuela );

ALTER TABLE direccion
    ADD CONSTRAINT direccion_comuna_fk FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE equipamiento
    ADD CONSTRAINT equip_escuela_deportiva_fk FOREIGN KEY ( id_escuela )
        REFERENCES escuela_deportiva ( id_escuela );

ALTER TABLE equipamiento
    ADD CONSTRAINT equip_tipo_equipamiento_fk FOREIGN KEY ( id_tipo_equipamiento )
        REFERENCES tipo_equipamiento ( id_tipo_equipamiento );

ALTER TABLE insumo
    ADD CONSTRAINT insumo_equipamiento_fk FOREIGN KEY ( id_equipamiento )
        REFERENCES equipamiento ( id_equipamiento );

ALTER TABLE insumo_tipo_equipamiento
    ADD CONSTRAINT insumo_tipo_equi_fk FOREIGN KEY ( id_tipo_equipamiento )
        REFERENCES tipo_equipamiento ( id_tipo_equipamiento );

ALTER TABLE insumo_tipo_equipamiento
    ADD CONSTRAINT ins_tip_equi_tipo_insumo_fk FOREIGN KEY ( id_tipo_insumo )
        REFERENCES tipo_insumo ( id_tipo_insumo );

ALTER TABLE insumo
    ADD CONSTRAINT insumo_tipo_insumo_fk FOREIGN KEY ( id_tipo_insumo )
        REFERENCES tipo_insumo ( id_tipo_insumo );

ALTER TABLE persona
    ADD CONSTRAINT persona_pais_fk FOREIGN KEY ( id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE personal
    ADD CONSTRAINT personal_escuela_deportiva_fk FOREIGN KEY ( id_escuela )
        REFERENCES escuela_deportiva ( id_escuela );

ALTER TABLE personal
    ADD CONSTRAINT personal_persona_fk FOREIGN KEY ( id_persona )
        REFERENCES persona ( id_persona );

ALTER TABLE profesion_persona
    ADD CONSTRAINT profesion_persona_persona_fk FOREIGN KEY ( id_persona )
        REFERENCES persona ( id_persona );

ALTER TABLE profesion_persona
    ADD CONSTRAINT profesion_persona_profesion_fk FOREIGN KEY ( id_profesion )
        REFERENCES profesion ( id_profesion );

ALTER TABLE remuneraciones
    ADD CONSTRAINT remuneraciones_personal_fk FOREIGN KEY ( id_escuela,
                                                            id_persona )
        REFERENCES personal ( id_escuela,
                              id_persona );

ALTER TABLE sede
    ADD CONSTRAINT sede_direccion_fk FOREIGN KEY (id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE sede
    ADD CONSTRAINT sede_escuela_deportiva_fk FOREIGN KEY ( id_escuela )
        REFERENCES escuela_deportiva ( id_escuela );