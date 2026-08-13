select * from cliente;

select * from TRANSACCION_PAGO;

select * from RESERVA_TEMPORAL;


SELECT c.nombre, rt.ESTADO as estado_de_reserva,tp.MONTO_BRUTO, tp.DESCUENTO,tp.MONTO_FINAL, tp.ESTADO as estado_de_pago  from cliente c
JOIN RESERVA_TEMPORAL rt on rt.cliente_id = c.cliente_id
JOIN TRANSACCION_PAGO tp on tp.RESERVA_ID = rt.RESERVA_ID
where rt.RESERVA_ID = 1
;
declare
beggin
    null;
end;