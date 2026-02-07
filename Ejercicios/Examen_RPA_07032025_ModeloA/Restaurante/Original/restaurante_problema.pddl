(define (problem restaurante-prob-ModA)
  (:domain restaurante-dom)
  (:objects
    persona1 persona2 persona3 persona4 persona5 - persona
    pan1 pan2 pan3 pan4 pan5 pan6 - porcion-pan
    fiambre1 fiambre2 fiambre3 fiambre4 fiambre5 fiambre6 - porcion-relleno
    bandeja1 bandeja2 bandeja3 - bandeja
    mesa1 mesa2 mesa3 - mesa
    boc1 boc2 boc3 - bocadillo
    cocina1 - cocina
  )
  (:init
    (en bandeja1 cocina1)
    (en pan1 cocina1)
    (en pan2 cocina1)
    (en pan3 cocina1)
    (en pan4 cocina1)
    (en pan5 cocina1)
    (en pan6 cocina1)
    (en fiambre1 cocina1)
    (en fiambre2 cocina1)
    (en fiambre3 cocina1)
    (en fiambre4 cocina1)
    (esperando persona1 mesa2)
    (esperando persona2 mesa1)
    (esperando persona3 mesa1)
    (esperando persona4 mesa2)
    (esperando persona5 mesa3)
    (nombre boc1)
    (nombre boc2)
    (nombre boc3)
    (adyacente cocina1 mesa1)
    (adyacente cocina1 mesa2)
    (adyacente mesa2 mesa3)
  )
  (:goal
    (and
      (servido persona1)
      (servido persona3)
      (servido persona4)
      (servido persona5)
    )
  )
)
