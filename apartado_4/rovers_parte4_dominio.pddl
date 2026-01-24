(define (domain Rover-battery)
(:requirements :typing :strips :equality)
(:types rover waypoint store camera mode lander objective
       blevel battery
       traction terrain ; Nuevos tipos [Requisito A y B]
)

(:predicates (at ?x - rover ?y - waypoint) 
			(at_lander ?x - lander ?y - waypoint)
			; ELIMINADO (can_traverse ?r - rover ?x - waypoint ?y - waypoint)
			(equipped_for_soil_analysis ?r - rover)
			(equipped_for_rock_analysis ?r - rover)
			(equipped_for_imaging ?r - rover)
			(empty ?s - store)
			(have_rock_analysis ?r - rover ?w - waypoint)
			(have_soil_analysis ?r - rover ?w - waypoint)
			(full ?s - store)
			(calibrated ?c - camera ?r - rover) 
			(supports ?c - camera ?m - mode)
			(available ?r - rover)
			(visible ?w - waypoint ?p - waypoint)
			(have_image ?r - rover ?o - objective ?m - mode)
			(communicated_soil_data ?w - waypoint)
			(communicated_rock_data ?w - waypoint)
			(communicated_image_data ?o - objective ?m - mode)
			(at_soil_sample ?w - waypoint)
			(at_rock_sample ?w - waypoint)
			(visible_from ?o - objective ?w - waypoint)
			(store_of ?s - store ?r - rover)
			(calibration_target ?i - camera ?o - objective)
			(on_board ?i - camera ?r - rover)
			(channel_free ?l - lander)
			(battery_installed ?r - rover ?b - battery ?bmax ?bcur - blevel)
			(lower ?l1 ?l2 - blevel)

			; Nuevos predicados para Requisitos A, B y C
			(has_traction ?r - rover ?t - traction)       ; El rover r tiene traccion t
			(path_type ?x - waypoint ?y - waypoint ?t - terrain) ; El camino x->y es de tipo t
			(compatible ?tr - traction ?te - terrain)     ; La traccion tr sirve para el terreno te
)

	
(:action navigate-bat
	:parameters (?r - rover ?y - waypoint ?z - waypoint
				?b - battery ?bmax ?bcur ?bnext - blevel
				?tr - traction ?te - terrain ; Nuevos parametros
				) 
	:precondition (and 
					(available ?r) 
					(at ?r ?y) 
					(visible ?y ?z)
					(battery_installed ?r ?b ?bmax ?bcur)
					(lower ?bnext ?bcur)

					; Nueva logica de movimiento
					(has_traction ?r ?tr)          ; El rover tiene cierta traccion
					(path_type ?y ?z ?te)          ; El camino es de cierto terreno
					(compatible ?tr ?te)           ; Son compatibles
	)
	:effect (and 
				(not (at ?r ?y)) 
				(at ?r ?z)
				(not (battery_installed ?r ?b ?bmax ?bcur))
				(battery_installed ?r ?b ?bmax ?bnext)
	)
)

(:action tow
:parameters (?r1 - rover ?r2 - rover ?y - waypoint ?z - waypoint
             ?b - battery ?bmax ?bcur ?bnext - blevel
             ?tr - traction ?te - terrain)
:precondition (and 
    (available ?r1) (available ?r2)
    (at ?r1 ?y) (at ?r2 ?y)        ; Ambos deben empezar en el mismo punto
    (not (= ?r1 ?r2))              ; No puede remolcarse a si mismo
    (visible ?y ?z)
    
    ; Restricciones de terreno solo para el rover que remolca (?r1)
    (has_traction ?r1 ?tr)
    (path_type ?y ?z ?te)
    (compatible ?tr ?te)
    
    ; Bateria solo requerida para ?r1
    (battery_installed ?r1 ?b ?bmax ?bcur)
    (lower ?bnext ?bcur)
)
:effect (and 
    (not (at ?r1 ?y)) (at ?r1 ?z)
    (not (at ?r2 ?y)) (at ?r2 ?z) ; El segundo rover tambien se mueve
    
    ; Consumo de bateria solo para ?r1
    (not (battery_installed ?r1 ?b ?bmax ?bcur))
    (battery_installed ?r1 ?b ?bmax ?bnext)
)
)

(:action recharge
:parameters (?r - rover ?l - lander ?w - waypoint
              ?b - battery ?bmax ?bcur - blevel
) 
:precondition (and (at ?r ?w) (at_lander ?l ?w)
                (battery_installed ?r ?b ?bmax ?bcur)
	    )
:effect (and 
             (not (battery_installed ?r ?b ?bmax ?bcur) )
             (battery_installed ?r ?b ?bmax ?bmax)
		)
)

(:action sample_soil
:parameters (?r - rover ?s - store ?p - waypoint)
:precondition (and (at ?r ?p) (at_soil_sample ?p) (equipped_for_soil_analysis ?r) (store_of ?s ?r) (empty ?s)
		)
:effect (and (not (empty ?s)) (full ?s) (have_soil_analysis ?r ?p) (not (at_soil_sample ?p))
		)
)

(:action sample_rock
:parameters (?r - rover ?s - store ?p - waypoint)
:precondition (and (at ?r ?p) (at_rock_sample ?p) (equipped_for_rock_analysis ?r) (store_of ?s ?r)(empty ?s)
		)
:effect (and (not (empty ?s)) (full ?s) (have_rock_analysis ?r ?p) (not (at_rock_sample ?p))
		)
)

(:action drop
:parameters (?r - rover ?s - store)
:precondition (and (store_of ?s ?r) (full ?s)
		)
:effect (and (not (full ?s)) (empty ?s)
	)
)

(:action calibrate
 :parameters (?r - rover ?i - camera ?t - objective ?w - waypoint)
 :precondition (and (equipped_for_imaging ?r) (calibration_target ?i ?t) (at ?r ?w) (visible_from ?t ?w)(on_board ?i ?r)
		)
 :effect (calibrated ?i ?r) 
)




(:action take_image
 :parameters (?r - rover ?p - waypoint ?o - objective ?i - camera ?m - mode)
 :precondition (and (calibrated ?i ?r)
			 (on_board ?i ?r)
                      (equipped_for_imaging ?r)
                      (supports ?i ?m)
			  (visible_from ?o ?p)
                     (at ?r ?p)
               )
 :effect (and (have_image ?r ?o ?m)(not (calibrated ?i ?r))
		)
)


(:action communicate_soil_data
 :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
 :precondition (and (at ?r ?x)(at_lander ?l ?y)(have_soil_analysis ?r ?p) 
                   (visible ?x ?y)(available ?r)(channel_free ?l)
            )
 :effect (and (not (available ?r))(not (channel_free ?l))(channel_free ?l)
		(communicated_soil_data ?p)(available ?r)
	)
)

(:action communicate_rock_data
 :parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
 :precondition (and (at ?r ?x)(at_lander ?l ?y)(have_rock_analysis ?r ?p)
                   (visible ?x ?y)(available ?r)(channel_free ?l)
            )
 :effect (and (not (available ?r))(not (channel_free ?l))(channel_free ?l)(communicated_rock_data ?p)(available ?r)
          )
)


(:action communicate_image_data
 :parameters (?r - rover ?l - lander ?o - objective ?m - mode ?x - waypoint ?y - waypoint)
 :precondition (and (at ?r ?x)(at_lander ?l ?y)(have_image ?r ?o ?m)(visible ?x ?y)(available ?r)(channel_free ?l)
            )
 :effect (and (not (available ?r))(not (channel_free ?l))(channel_free ?l)(communicated_image_data ?o ?m)(available ?r)
          )
)

)
