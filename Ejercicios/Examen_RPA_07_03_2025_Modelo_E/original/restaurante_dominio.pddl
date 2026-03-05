(define (domain restaurante-dom)
  (:requirements :typing :strips :disjunctive-preconditions)

  (:types
    persona porcion-pan porcion-relleno bocadillo bandeja - ubicable
    cocina mesa - lugar
    bocadillo - nombre-comida
  )

  (:predicates
    (en ?obj - ubicable ?l1 - lugar)
    (en-bandeja ?nc - bocadillo ?t - bandeja)
    (servido ?p - persona)
    (esperando ?p - persona ?l - lugar)
    (nombre ?nc - bocadillo)
    (adyacente ?l1 ?l2 - lugar)
  )

  (:action hacer_bocadillo
    :parameters (?nb - bocadillo ?b - porcion-pan ?r - porcion-relleno ?k - cocina)
    :precondition (and (en ?b ?k) (en ?r ?k) (nombre ?nb))
    :effect (and
      (not (en ?b ?k))
      (not (en ?r ?k))
      (en ?nb ?k)
      (not (nombre ?nb))
    )
  )

  (:action poner_en_bandeja
    :parameters (?nc - bocadillo ?t - bandeja ?k - cocina)
    :precondition (and (en ?nc ?k) (en ?t ?k))
    :effect (and
      (not (en ?nc ?k))
      (en-bandeja ?nc ?t)
    )
  )

  (:action servir_comida
    :parameters (?nc - nombre-comida ?p - persona ?t - bandeja ?l - lugar)
    :precondition (and
      (esperando ?p ?l)
      (en-bandeja ?nc ?t)
      (en ?t ?l)
    )
    :effect (and
      (not (en-bandeja ?nc ?t))
      (servido ?p)
      (nombre ?nc)
    )
  )

  (:action mover_bandeja
    :parameters (?t - bandeja ?l1 ?l2 - lugar)
    :precondition (and (en ?t ?l1)
        (or (adyacente ?l1 ?l2) (adyacente ?l2 ?l1)) 
    )
      
    :effect (and (not (en ?t ?l1))
                 (en ?t ?l2))
  )
)