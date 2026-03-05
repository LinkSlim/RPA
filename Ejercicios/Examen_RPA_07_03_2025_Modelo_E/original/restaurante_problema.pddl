(define (problem restaurante-prob-ModE)
  (:domain restaurante-dom)
  (:objects
    personal1 personal2 personal3 personal4 personal5 - persona
    pan1 pan2 pan3 pan4 pan5 pan6 - porcion-pan
    fiambre1 fiambre2 fiambre3 fiambre4 fiambre5 fiambre6 - porcion-relleno
    bandeja1 bandeja2 bandeja3 - bandeja
    mesa1 mesa2 mesa3 mesa4 - mesa
    boc1 boc2 boc3 boc4 - bocadillo
    cocina2 - cocina
  )

  (:init
    (en bandeja1 cocina2)
    (en bandeja3 cocina2)
    (en pan2 cocina2)
    (en pan3 cocina2)
    (en pan4 cocina2)
    (en fiambre2 cocina2)
    (en fiambre3 cocina2)
    (en fiambre4 cocina2)
    (en boc1 cocina2)
    (esperando personal1 mesa2)
    (esperando personal2 mesa3)
    (esperando personal3 mesa1)
    (esperando personal4 mesa1)
    (esperando personal5 mesa3)
    (nombre boc2)
    (nombre boc3)
    (nombre boc4)
    (adyacente cocina2 mesa1)
    (adyacente mesa1 mesa2)
    (adyacente mesa1 mesa4)
    (adyacente cocina2 mesa3)
    (adyacente cocina2 mesa4)
  )

  (:goal
    (and
      (servido personal1)
      (servido personal2)
      (servido personal3)
      (servido personal4)
      (en bandeja3 mesa4)
    )
  )
)