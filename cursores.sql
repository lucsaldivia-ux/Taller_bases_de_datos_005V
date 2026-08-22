SELECT * from cliente;

DECLARE
    CURSOR c_clientes IS 
        select * from cliente;

BEGIN

    for un_cliente in c_clientes LOOP

    DBMS_OUTPUT.PUT_LINE('el nombre e:  '|| un_cliente.nombre);

    END LOOP;
    null;
END;
/

--creemos la boleta para todos los clientes que tienen la compra aprobada

SELECT c.nombre, rt.ESTADO as estado_de_reserva,tp.MONTO_BRUTO, tp.DESCUENTO,tp.MONTO_FINAL, tp.ESTADO as estado_de_pago  from cliente c
JOIN RESERVA_TEMPORAL rt on rt.cliente_id = c.cliente_id
JOIN TRANSACCION_PAGO tp on tp.RESERVA_ID = rt.RESERVA_ID
where tp.ESTADO = 'APROBADO'
;

SELECT * from TRANSACCION_PAGO;

DECLARE
    CURSOR C_APROBADO is
    SELECT c.nombre, rt.ESTADO as estado_de_reserva,tp.MONTO_BRUTO, tp.DESCUENTO,tp.MONTO_FINAL, tp.ESTADO as estado_de_pago    
    from cliente c
    JOIN RESERVA_TEMPORAL rt on rt.cliente_id = c.cliente_id
    JOIN TRANSACCION_PAGO tp on tp.RESERVA_ID = rt.RESERVA_ID
    where tp.ESTADO = 'APROBADO';
    v_contador NUMBER:=1
;
BEGIN
    FOR APROBADOS IN C_APROBADO LOOP
    DBMS_OUTPUT.PUT_LINE('VAMOS EN LA VUELTA NUMERO: '|| v_contador);
    DBMS_OUTPUT.PUT_LINE('*****************************************');
    DBMS_OUTPUT.PUT_LINE('EL NOMBRE: '|| APROBADOS.NOMBRE);
    DBMS_OUTPUT.PUT_LINE('EL ESTADO DE TRANSACCION: '|| APROBADOS.estado_de_pago);
    DBMS_OUTPUT.PUT_LINE('EL MONTO ES: '|| APROBADOS.monto_final);
    DBMS_OUTPUT.PUT_LINE('*****************************************');
v_contador := v_contador+1;
        END LOOP;

END;
/
