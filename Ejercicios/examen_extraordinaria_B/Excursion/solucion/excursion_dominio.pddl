(define (domain excursion_2425_ModB)
    (:requirements :typing :equality :negative-preconditions :disjunctive-preconditions)
    (:types
        madera persona lugar
    )
    (:predicates
        (madera_en ?x1 - madera ?x2 - lugar)
        (persona_en ?x1 - persona ?x2 - lugar)
        (dormida_en ?x1 - persona ?x2 - lugar)
        (camino_entre ?x1 ?x2 - lugar)
        (cansada ?x1 - persona)
        (refugio_en ?x1 - lugar)
        (mosquitos ?x1 - lugar)
    )

    (:action caminar
        :parameters ( ?x1 - persona ?x2 - lugar ?x3 - lugar)
        :precondition (and
            (persona_en ?x1 ?x2) (camino_entre ?x2 ?x3)
            (not (cansada ?x1))
        )
        :effect (and (persona_en ?x1 ?x3)
            (not (persona_en ?x1 ?x2))
            (cansada ?x1)
        )
    )

    (:action dormir
        :parameters ( ?x1 - persona ?x2 - lugar)
        :precondition (and
            (persona_en ?x1 ?x2)
            (or (refugio_en ?x2)
                (not (mosquitos ?x2))
            )
        )
        :effect (and (dormida_en ?x1 ?x2)
            (not (persona_en ?x1 ?x2))
        )
    )

    (:action despertar
        :parameters ( ?x1 - persona ?x2 - lugar)
        :precondition (and
            (dormida_en ?x1 ?x2)
        )
        :effect (and (not (dormida_en ?x1 ?x2))
            (not (cansada ?x1))
            (persona_en ?x1 ?x2)
        )
    )

    (:action construir_refugio
        :parameters ( ?x1 - persona ?x2 - lugar ?x3 - madera)
        :precondition (and
            (persona_en ?x1 ?x2)
            (madera_en ?x3 ?x2)
        )
        :effect (and (not (madera_en ?x3 ?x2))
            (refugio_en ?x2)
            (cansada ?x1)
        )
    )

)
