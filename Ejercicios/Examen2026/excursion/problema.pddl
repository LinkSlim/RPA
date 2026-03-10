(define (problem Mercados2526_q1_O_problema_1)
    (:domain Mercados2526_q1_O)
    (:objects
        producto1 producto2 - producto
        camion1 camion2 - camion
        mercado1 - mercado
        almacen1 - almacen
        num0 num1 num2 - num
    )
    (:init
        (siguiente-num num1 num0)
        (siguiente-num num2 num1)
        (preparado producto1 mercado1 num0)
        (preparado producto2 mercado1 num1)
        (almacenado producto1 num0)
        (almacenado producto2 num0)
        (cargado producto1 camion1 num1)
        (cargado producto2 camion1 num0)
        (cargado producto1 camion2 num2)
        (cargado producto2 camion2 num0)
        (conectado almacen1 mercado1)
        (conectado mercado1 almacen1)
        (en-venta producto1 mercado1)
        (en-venta producto2 mercado1)
        (en camion1 almacen1)
        (en camion2 mercado1)
    )
    (:goal
        (and
            (almacenado producto1 num1)
            (almacenado producto2 num1)
        )
    )
)