CREATE SEQUENCE equipamiento_id_equipamiento START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER equipamiento_id_equipamiento BEFORE
    INSERT ON equipamiento
    FOR EACH ROW
    WHEN ( new.id_equipamiento IS NULL )
BEGIN
    :new.id_equipamiento := equipamiento_id_equipamiento.nextval;
END;


CREATE SEQUENCE escuela_deportiva_id_escuela START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER escuela_deportiva_id_escuela BEFORE
    INSERT ON escuela_deportiva
    FOR EACH ROW
    WHEN ( new.id_escuela IS NULL )
BEGIN
    :new.id_escuela := escuela_deportiva_id_escuela.nextval;
END;


CREATE SEQUENCE insumo_id_insumo_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER insumo_id_insumo_trg BEFORE
    INSERT ON insumo
    FOR EACH ROW
    WHEN ( new.id_insumo IS NULL )
BEGIN
    :new.id_insumo := insumo_id_insumo_seq.nextval;
END;


CREATE SEQUENCE persona_id_persona_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER persona_id_persona_trg BEFORE
    INSERT ON persona
    FOR EACH ROW
    WHEN ( new.id_persona IS NULL )
BEGIN
    :new.id_persona := persona_id_persona_seq.nextval;
END;