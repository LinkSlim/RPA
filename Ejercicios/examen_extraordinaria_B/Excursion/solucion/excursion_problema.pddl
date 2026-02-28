(define (problem excursion_2425_ModB)
    (:domain excursion_2425_ModB)
    (:objects
        madera0 madera1 madera2 madera3 madera4 - madera
        lugar0 lugar1 lugar2 lugar3 lugar4 - lugar
        persona0 persona1 persona2 - persona
    )
    (:init
        ; Personas
        (persona_en persona0 lugar0)
        (persona_en persona1 lugar1)
        (persona_en persona2 lugar1)
        ; Recursos
        (madera_en madera0 lugar0)
        (madera_en madera1 lugar1)
        (madera_en madera2 lugar2)
        (madera_en madera3 lugar3)
        ; Otros
        (cansada persona1)
        (mosquitos lugar0)
        (mosquitos lugar1)
        ; Mapa 1
        (camino_entre lugar0 lugar2)
        (camino_entre lugar2 lugar0)
        (camino_entre lugar1 lugar2)
        (camino_entre lugar2 lugar1)
        (camino_entre lugar2 lugar3)
        (camino_entre lugar3 lugar2)
        (camino_entre lugar3 lugar4)
        (camino_entre lugar4 lugar3)
    )

    (:goal
        (and
            (persona_en persona1 lugar4)
            (persona_en persona0 lugar4)
            (refugio_en lugar4)
        )
    )
)