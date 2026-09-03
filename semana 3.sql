
SELECT * FROM CLIENTE;

SELECT * FROM CLIENTE WHERE CLIENTE_ID = 6;

--Este cuando no tare datos
DECLARE 
    v_nombre CLIENTE.NOMBRE%TYPE;
BEGIN 
        SELECT NOMBRE INTO v_nombre FROM CLIENTE WHERE EMAIL = 'asdsdfafsd@gmail.com';
        DBMS_OUTPUT.PUT_LINE('EL nombre es: ' ||  v_nombre);

    EXCEPTION
        WHEN no_data_found THEN
            DBMS_OUTPUT.PUT_LINE('Dato del cliente no encontrado x');

END;
/



SELECT * FROM CLIENTE;

--Este cuando trae muchos datos
DECLARE 
    v_nombre CLIENTE.NOMBRE%TYPE;
BEGIN 
        SELECT NOMBRE INTO v_nombre FROM CLIENTE WHERE CLIENTE_ID = 100;
        DBMS_OUTPUT.PUT_LINE('EL nombre es: ' ||  v_nombre);

    EXCEPTION
        WHEN no_data_found THEN
            DBMS_OUTPUT.PUT_LINE('Dato del cliente no encontrado x');
        WHEN too_many_rows THEN
            DBMS_OUTPUT.PUT_LINE('Demasiadas filas para esta variable');
END;
/



INSERT INTO CLIENTE (rut, nombre, apellido, email)
    VALUES ('19.556.789-1', 'Otro', 'Nombre', 'otro@gmail.com');
    commit;

SELECT * FROM CLIENTE;

commit;

--Que ´pasa cuando quiero insertar un valor que ya existe y ademas ese valor tiene restriccion de unicidad

BEGIN
    INSERT INTO CLIENTE (rut, nombre, apellido, email)
    VALUES ('19.456.789-1', 'Otro', 'Nombre', 'otro@gmail.com');
    commit;
    -- El RUT '19.456.789-1' ya existe (Valentina Soto)
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: el RUT ya está registrado.');
END;
/

--Casteo incorrecto
DECLARE
    v_num NUMBER;
BEGIN
    v_num := TO_NUMBER('abc');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: no se pudo convertir a número.');

    WHEN INVALID_NUMBER THEN
        DBMS_OUTPUT.PUT_LINE('Error: numero invalido');
END;
/

--Si mi consulta regresa mas de una fila, entones usamos el cursor

--Vamos a traer a todos los CLIENTES

SELECT * FROM CLIENTE;

DECLARE 
    CURSOR c_clientes IS 
        SELECT * FROM CLIENTE;

BEGIN
    FOR por_cada_cliente IN  c_clientes LOOP
        DBMS_OUTPUT.PUT_LINE('***** INFORME DE CLIENTES *****');
        DBMS_OUTPUT.PUT_LINE('Nombre ' || por_cada_cliente.NOMBRE);
        DBMS_OUTPUT.PUT_LINE('RUT ' || por_cada_cliente.rut);
        DBMS_OUTPUT.PUT_LINE('TELEFONO ' || por_cada_cliente.TELEFONO);
    END LOOP;
    null;
END;
/


--Cursor con JOIN
SELECT c.NOMBRE, rt.ESTADO AS ESTADO_DE_RESERVA, tp.MONTO_BRUTO, tp.DESCUENTO, tp.MONTO_FINAL, tp.ESTADO AS ESTADO_DE_PAGO FROM CLIENTE c 
JOIN RESERVA_TEMPORAL rt ON rt.CLIENTE_ID = c.CLIENTE_ID 
JOIN TRANSACCION_PAGO tp ON tp.RESERVA_ID = rt.RESERVA_ID
WHERE tp.ESTADO = 'APROBADO';


DECLARE
    CURSOR c_transacciones_aprobadas IS 
        SELECT c.NOMBRE, rt.ESTADO AS ESTADO_DE_RESERVA, tp.MONTO_BRUTO, tp.DESCUENTO, tp.MONTO_FINAL, tp.ESTADO AS ESTADO_DE_PAGO FROM CLIENTE c 
        JOIN RESERVA_TEMPORAL rt ON rt.CLIENTE_ID = c.CLIENTE_ID 
        JOIN TRANSACCION_PAGO tp ON tp.RESERVA_ID = rt.RESERVA_ID
        WHERE tp.ESTADO = 'APROBADO';
BEGIN
        DBMS_OUTPUT.PUT_LINE('***TRANSACCIONES APROBADAS***');

    FOR i IN c_transacciones_aprobadas LOOP
        DBMS_OUTPUT.PUT_LINE('******');

        DBMS_OUTPUT.PUT_LINE('Nombre ' || i.NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Monto FInal ' || i.MONTO_FINAL);
        DBMS_OUTPUT.PUT_LINE('Estado ' || i.ESTADO_DE_PAGO);

    END LOOP;
    
END;
/

SELECT * FROM CLIENTE;

INSERT INTO CLIENTE(RUT, NOMBRE, apellido, EMAIL, TELEFONO, FECHA_REGISTRO) VALUES ('11.111.111-1', 'Juan', 'Vargas', 'jvargas@gmail.com', '+56911111111', SYSTIMESTAMP);
INSERT INTO CLIENTE(RUT, NOMBRE, apellido, EMAIL, TELEFONO, FECHA_REGISTRO) VALUES ('22.222.222-2', 'Valentina', 'Vargas', 'vvargas@gmail.com', '+56922222222', SYSTIMESTAMP);
INSERT INTO CLIENTE(RUT, NOMBRE, apellido, EMAIL, TELEFONO, FECHA_REGISTRO) VALUES ('33.333.333-6', 'Matias', 'Vargas', 'mvargas@gmail.com', '+56933333333', SYSTIMESTAMP);

COMMIT;
--Todos los vargas
DECLARE
    CURSOR c_clientes_por_apellido( p_apellido VARCHAR2, p_nombre_contenga_letra VARCHAR2) IS
        SELECT cliente_id,nombre, apellido, email
        FROM CLIENTE
        WHERE apellido = p_apellido AND NOMBRE LIKE p_nombre_contenga_letra;

        TYPE v_nombres IS VARRAY(5) OF VARCHAR2(20);

        v_arreglo_nombres v_nombres := v_nombres('Vargas', 'Soto', 'Morales', 'Pérez');

BEGIN
    FOR un_cliente IN c_clientes_por_apellido(v_arreglo_nombres(1), '%i%')
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            un_cliente.nombre
        );
    END LOOP;
END;
/

