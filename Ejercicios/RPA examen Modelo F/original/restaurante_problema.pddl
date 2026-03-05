(define (problem restaurante-prob-ModF)
  (:domain restaurante-dom)

  (:objects
    persona1 persona2 persona3 persona4 persona5 - persona
    pan1 pan2 pan3 pan4 pan5 pan6 - porcion-pan
    fiambre1 fiambre2 fiambre3 fiambre4 fiambre5 fiambre6 - porcion-relleno
    bandeja1 bandeja2 bandeja3 - bandeja
    mesa1 mesa2 mesa3 - mesa
    boc1 boc2 boc3 boc4 - bocadillo
    cocina1 cocina2 - cocina
  )

  (:init
    (en bandeja1 cocina1)
    (en bandeja2 cocina2)
    (en pan1 cocina2)
    (en pan2 cocina2)
    (en pan3 cocina2)
    (en pan4 cocina1)
    (en fiambre1 cocina1)
    (en fiambre2 cocina1)
    (en fiambre3 cocina2)
    (en fiambre4 cocina2)
    (en fiambre5 cocina2)
    (esperando persona1 mesa2)
    (esperando persona2 mesa1)
    (esperando persona3 mesa1)
    (esperando persona4 mesa2)
    (esperando persona5 mesa3)
    (nombre boc1)
    (nombre boc3)
    (nombre boc4)
    (adyacente cocina1 mesa1)
    (adyacente cocina1 mesa2)
    (adyacente mesa2 mesa3)
    (adyacente cocina2 mesa3)
  )

  (:goal
    (and
      (servido persona1)
      (servido persona2)
      (servido persona4)
      (servido persona5)
      (en bandeja1 cocina2)
      (en bandeja2 mesa3)
    )
  )
)