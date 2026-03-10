(define (domain Mercados2526_q1_O)
    (:requirements :typing :strips)
    (:types
        lugar ubicable num - object
        almacen mercado - lugar
        camion producto - ubicable
    )
    (:predicates
        (cargado ?p - producto ?cam - camion ?n - num)
        (preparado ?p - producto ?m - mercado ?n - num)
        (almacenado ?p - producto ?n - num)
        (en-venta ?p - producto ?m - mercado)
        (siguiente-num ?n1 ?n2 - num)
        (en ?cam - camion ?p - lugar)
        (conectado ?p1 ?p2 - lugar)
    )

    (:action conducir
        :parameters (?cam - camion ?desde ?hasta - lugar)
        :precondition (and (en ?cam ?desde) (conectado ?desde ?hasta))
        :effect (and (not (en ?cam ?desde)) (en ?cam ?hasta))
    )

    (:action cargar
        :parameters (?p - producto ?cam - camion ?m - mercado ?n1 ?n2 ?n3 ?n4 - num)
        :precondition (and (en ?cam ?m) (cargado ?p ?cam ?n3)
            (preparado ?p ?m ?n2) (siguiente-num ?n2 ?n1) (siguiente-num ?n4 ?n3))
        :effect (and (cargado ?p ?cam ?n4) (not (cargado ?p ?cam ?n3))
            (preparado ?p ?m ?n1) (not (preparado ?p ?m ?n2)))
    )

    (:action descargar
        :parameters (?p - producto ?cam - camion ?a - almacen ?n1 ?n2 ?n3 ?n4 - num)
        :precondition (and (en ?cam ?a) (cargado ?p ?cam ?n2)
            (almacenado ?p ?n3) (siguiente-num ?n2 ?n1) (siguiente-num ?n4 ? n3))
        :effect (and (cargado ?p ?cam ?n1) (not (cargado ?p ?cam ?n2))
            (almacenado ?p ?n4) (not (almacenado ?p ?n3)))
    )
    (:action comprar
        :parameters (?cam - camion ?p - producto ?m - mercado ?n1 ?n2 - num)
        :precondition (and (en ?cam ?m) (en-venta ?p ?m) (preparado ?p ?m ?n1)
            (siguiente-num ?n2 ?n1)
        )
        :effect (and
            (preparado ?p ?m ?n2) (not (preparado ?p ?m ?n1)))
    )
)