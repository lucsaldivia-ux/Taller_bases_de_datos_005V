 --ejercicio 1
 DECLARE
    TYPE r_recinto_info IS RECORD (
        nombre      recinto.nombre%TYPE,
        direccion   recinto.direccion%TYPE,
        ciudad      recinto.ciudad%TYPE,
        capacidad   recinto.capacidad_total%TYPE
    );
    
    v_recinto r_recinto_info;
    p_recinto_id recinto.RECINTO_ID%TYPE := 1; 

BEGIN
    SELECT nombre, direccion, ciudad, capacidad_total
    INTO v_recinto
    FROM recinto
    WHERE RECINTO_ID = p_recinto_id;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_recinto.nombre);
    DBMS_OUTPUT.PUT_LINE('Dirección: ' || v_recinto.direccion);
    DBMS_OUTPUT.PUT_LINE('Ciudad: ' || v_recinto.ciudad);
    DBMS_OUTPUT.PUT_LINE('Capacidad Total: ' || v_recinto.capacidad);

EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(' El recinto con ID ' || p_recinto_id || ' no existe.');
        
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('La consulta devolvió múltiples recintos para el ID ' || p_recinto_id || '.');
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado.');
        DBMS_OUTPUT.PUT_LINE('Código de error: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Mensaje de error: ' || SQLERRM);
END;
/

--ejercicio 3

DECLARE
    CURSOR c_tickets_emitidos IS
        SELECT 
            t.codigo_ticket,
            c.nombre || ' ' || c.apellido AS nombre_cliente,
            tp.monto_final                 AS precio_pagado,
            tp.metodo_pago
        FROM TICKET t
        JOIN TRANSACCION_PAGO tp ON t.transaccion_id = tp.transaccion_id
        JOIN RESERVA_TEMPORAL rt ON t.reserva_id     = rt.reserva_id
        JOIN CLIENTE c          ON rt.cliente_id     = c.cliente_id
        WHERE t.estado = 'EMITIDO';

BEGIN
    FOR r_ticket IN c_tickets_emitidos LOOP
        DBMS_OUTPUT.PUT_LINE('Ticket: '|| r_ticket.codigo_ticket ||' | Cliente: ' || r_ticket.nombre_cliente ||' | Precio: $'    || TO_CHAR(r_ticket.precio_pagado, 'FM999,999,990') || ' | Método Pago: '|| r_ticket.metodo_pago);
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/
--ejercicio 4

DECLARE
    e_sin_eventos_vigentes EXCEPTION;

    CURSOR c_eventos_productora(p_productora_id NUMBER) IS
        SELECT nombre, fecha_evento, estado
        FROM EVENTO
        WHERE productora_id = p_productora_id;

    v_productora_id NUMBER := 1; 
    v_contador      NUMBER := 0;

BEGIN
    FOR r_evento IN c_eventos_productora(v_productora_id) LOOP
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE('Evento: '  || r_evento.nombre || ' | Fecha: ' || TO_CHAR(r_evento.fecha_evento, 'DD/MM/YYYY HH24:MI') || ' | Estado: '|| r_evento.estado);
    END LOOP;

    IF v_contador = 0 THEN
        RAISE e_sin_eventos_vigentes;
    END IF;

EXCEPTION
    WHEN e_sin_eventos_vigentes THEN
        DBMS_OUTPUT.PUT_LINE('ALERTA: La productora ID ' || v_productora_id || ' no registra eventos en cartelera.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error del sistema (' || SQLCODE || '): ' || SQLERRM);
END;
/