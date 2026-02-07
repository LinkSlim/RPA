(define (problem restaurante-prob-ModA)
  (:domain restaurante-dom)
  (:objects
    comensal1 comensal2 comensal3 comensal4 comensal5 - comensal
    cocinero1 cocinero2 - cocinero
    pan1 pan2 pan3 pan4 pan5 pan6 - porcion-pan
    fiambre1 fiambre2 fiambre3 fiambre4 fiambre5 fiambre6 - porcion-relleno
    bandeja1 bandeja2 bandeja3 - bandeja
    mesa1 mesa2 mesa3 - mesa
    boc1 boc2 boc3 - bocadillo
    cocina1 cocina2 - cocina
  )
  (:init
    (en bandeja1 cocina1)
    (en cocinero1 cocina1)
    (en cocinero2 cocina1)
    (en pan1 cocina1)
    (en pan2 cocina1)
    (en pan3 cocina1)
    (en pan4 cocina2)
    (en pan5 cocina2)
    (en pan6 cocina2)
    (en fiambre1 cocina1)
    (en fiambre2 cocina1)
    (en fiambre3 cocina2)
    (en fiambre4 cocina2)
    (en fiambre5 cocina2)
    (esperando comensal1 mesa2)
    (esperando comensal2 mesa1)
    (esperando comensal3 mesa1)
    (esperando comensal4 mesa2)
    (esperando comensal5 mesa3)
    (nombre boc1)
    (nombre boc2)
    (nombre boc3)
    (adyacente cocina1 mesa1)
    (adyacente cocina1 mesa2)
    (adyacente cocina1 cocina2)
    (adyacente mesa2 mesa3)
  )
  (:goal
    (and
      (servido comensal1)
      (servido comensal2)
      (servido comensal3)
      (servido comensal4)
      (servido comensal5)
    )
  )
)
