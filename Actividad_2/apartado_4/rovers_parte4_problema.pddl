(define (problem roverprob1234) (:domain Rover-battery-2)
(:objects
	general - Lander
	colour high_res low_res - Mode
	rover0 rover1 - Rover ; Agrego nuevo rover1
	rover0store rover1store - Store ; Agrego nuevo store para rover1
	waypoint0 waypoint1 waypoint2 waypoint3 - Waypoint
	camera0 camera1 - Camera ; Agrego nueva camara para rover1
	objective0 objective1 - Objective
    b0 b1 b2 b3 b4 b5 - Blevel
    bat0 bat1 - Battery ; Agrego nueva bateria para rover1

	; tracciones para los rovers
    ruedas oruga patas - traccion
	; nuevos tipos de terreno
    llano rocoso arenoso - terreno
	)
(:init
	(visible waypoint1 waypoint0)
	(visible waypoint0 waypoint1)
	(visible waypoint2 waypoint0)
	(visible waypoint0 waypoint2)
	(visible waypoint2 waypoint1)
	(visible waypoint1 waypoint2)
	(visible waypoint3 waypoint0)
	(visible waypoint0 waypoint3)
	(visible waypoint3 waypoint1)
	(visible waypoint1 waypoint3)
	(visible waypoint3 waypoint2)
	(visible waypoint2 waypoint3)

	
	; Equipamos la traccion de cada rover
    (has_traccion rover0 ruedas)
    (has_traccion rover1 oruga)
    (has_traccion rover1 patas)
    
    ; Configuracion de cada relacion traccion y terreno
    
    (compatible ruedas llano)
    (compatible oruga llano)
    (compatible patas rocoso)
    (compatible oruga arenoso)
    
    
    ;Definicion de los caminos y el terreno que son
    
    ; Caminos con waypoint0 terreno llano
    (path_type waypoint0 waypoint1 llano)
    (path_type waypoint1 waypoint0 llano)
    (path_type waypoint0 waypoint2 llano)
    (path_type waypoint2 waypoint0 llano)
    (path_type waypoint1 waypoint2 llano)
    (path_type waypoint2 waypoint1 llano)
    
    ; Caminos entre 1, 2 y 3 que son rocosos y arenosos
    (path_type waypoint1 waypoint3 rocoso)
    (path_type waypoint3 waypoint1 rocoso)
    (path_type waypoint2 waypoint3 arenoso)
    (path_type waypoint3 waypoint2 arenoso)

	; muestras solo waypoint3
	(at_soil_sample waypoint3)
	(at_rock_sample waypoint3)

	(at_lander general waypoint0)
	(channel_free general)

	; Posicion inicial rovers en waypoint0
	(at rover0 waypoint0)
	(at rover1 waypoint0) 
	(available rover0)
	(available rover1) 	
	(store_of rover0store rover0)
	(store_of rover1store rover1) 
	(empty rover0store)
	(empty rover1store) 

	; equipamos rovers para analisis de suelo y roca	
	(equipped_for_soil_analysis rover0)
	(equipped_for_soil_analysis rover1) 
	(equipped_for_rock_analysis rover0)
	(equipped_for_rock_analysis rover1)


	(equipped_for_imaging rover0)
	(equipped_for_imaging rover1) ; rover1 equipado para obtener imagenes

	; Configuracion en ambos modos solo para el rover0
	(on_board camera0 rover0)
	(calibration_target camera0 objective1)
	(supports camera0 colour) ; camera0 configurada para imagenes a color
	(supports camera0 high_res) ; camera0 configurada para alta resolucion
	(supports camera0 low_res) ; camera0 configurada para baja resolucion

	; Bateria cargada en rovers
	(battery_installed rover0 bat0 b4 b4) ; Bateria1 instalada y cargada en rover0
	(battery_installed rover1 bat1 b4 b4) ; Bateria1 instalada y cargada en rover1
	; Niveles de bateria
	(lower b0 b1) (lower b1 b2) (lower b2 b3) (lower b3 b4) (lower b4 b5)
	; Visibilidad de objetivos
	(visible_from objective1 waypoint3)
)

(:goal (and
   (communicated_soil_data waypoint3)
   (communicated_rock_data waypoint3)
   (communicated_image_data objective1 colour) ; Agregamos goal, foto en color de objetivo1
   (communicated_image_data objective1 high_res) ; Agregamos goal, foto en baja resolucion de objetivo1
   (communicated_image_data objective1 low_res) ; Agregamos goal, foto en alta resolucion de objetivo1
   )
)
)

; Solo rover1 puede ir por rocoso y arenoso.
; Solo rover0 puede hacer las fotos
; Camino entre waypoint1 - waypoint3 es de tipo rocoso y  camino entre waypoint2 - waypoint3 es de tipo arenoso
; rover1 tiene que remolcar a rover0 con tow para llevarlo a waypoint3 con traccion de tipo oruga
; rover0 toma las fotos en todos los modos (colour, high_res y low_res) del objetivo1
