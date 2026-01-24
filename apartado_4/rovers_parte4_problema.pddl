(define (problem roverprob1234) (:domain Rover-battery)
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

	; [Requisito A y B] Nuevos objetos
    ruedas oruga - traction
    llano rocoso arenoso - terrain
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

	
	; [Requisito A] Definir la traccion de cada rover
    (has_traction rover0 ruedas)
    (has_traction rover1 oruga)
    
    ; [Requisito C] Definir que traccion sirve para que terreno
    ; Ejemplo: Ruedas solo van por llano. Oruga va por llano, rocoso y arenoso.
    (compatible ruedas llano)
    (compatible oruga llano)
    (compatible oruga rocoso)
    (compatible oruga arenoso)
    
    ; [Requisito B] Definir el tipo de terreno de cada conexion
    ; Esto sustituye a todas las lineas (can_traverse ...) originales.
    ; Asignamos terrenos a las conexiones visibles definidas en source: 1
    
    ; Conexiones con waypoint0 (Digamos que son llanas)
    (path_type waypoint1 waypoint0 llano) (path_type waypoint0 waypoint1 llano)
    (path_type waypoint2 waypoint0 llano) (path_type waypoint0 waypoint2 llano)
    (path_type waypoint3 waypoint0 llano) (path_type waypoint0 waypoint3 llano)
    
    ; Conexiones entre 1, 2 y 3 (Digamos que son dificiles/rocosas)
    ; Nota: Como rover0 tiene ruedas, NO podra pasar por aqui solo.
    ; Esto fuerza a usar rover1 o que rover1 remolque a rover0.
    (path_type waypoint2 waypoint1 rocoso) (path_type waypoint1 waypoint2 rocoso)
    (path_type waypoint3 waypoint1 rocoso) (path_type waypoint1 waypoint3 rocoso)
    (path_type waypoint3 waypoint2 rocoso) (path_type waypoint2 waypoint3 rocoso)

  


  
	(at_soil_sample waypoint0)
	(at_rock_sample waypoint1)
	(at_soil_sample waypoint2)
	(at_rock_sample waypoint2)
	(at_soil_sample waypoint3)
	(at_rock_sample waypoint3)
	(at_lander general waypoint0)
	(channel_free general)
	(at rover0 waypoint3)
	(at rover1 waypoint3) ; Posicion inicial del rover1
	(available rover0)
	(available rover1) ; rover1 disponible
	(store_of rover0store rover0)
	(store_of rover1store rover1) ; store1 para rover1
	(empty rover0store)
	(empty rover1store) ; Vacio store1 de rover1
	(equipped_for_soil_analysis rover0)
	(equipped_for_soil_analysis rover1) ; rover1 equipado para analisis de suelo
	(equipped_for_rock_analysis rover0)
	(equipped_for_rock_analysis rover1) ; rover1 equipado para analisis de rocas
	(equipped_for_imaging rover0)
	(equipped_for_imaging rover1) ; rover1 equipado para imagenes


	; Nuevas capacidades de movimiento para rover1, las mismas que para rover0
	;ELIMINADO (can_traverse rover1 waypoint3 waypoint0)
	;ELIMINADO (can_traverse rover1 waypoint0 waypoint3)
	;ELIMINADO (can_traverse rover1 waypoint3 waypoint1)
	;ELIMINADO (can_traverse rover1 waypoint1 waypoint3)
	;ELIMINADO (can_traverse rover1 waypoint1 waypoint2)
	;ELIMINADO (can_traverse rover1 waypoint2 waypoint1)

	(on_board camera0 rover0)
	(on_board camera1 rover1) ; Nueva camara1 a bordo del rover1
	(calibration_target camera0 objective1)
	(calibration_target camera1 objective1) ; Nueva camara1 calibrada para objective1
	(supports camera0 colour)
	(supports camera1 colour) ; camera1 soporta modo color
	(supports camera0 high_res)
	; Para que se saquen las fotografias de todos los objetivos en ambos modos
	(supports camera1 high_res) ; camera1 soporta alta resolucion
	(supports camera0 low_res) ; camera0 soporta baja resolucion
	(supports camera1 low_res) ; camera1 soporta baja resolucion
	; Bateria cargada en rover 0
	(battery_installed rover0 bat0 b4 b4)
	(battery_installed rover1 bat1 b4 b4) ; Bateria1 instalada y cargada en rover1
	; Niveles de bateria
	(lower b0 b1) (lower b1 b2) (lower b2 b3) (lower b3 b4) (lower b4 b5)
	; Visibilidad de objetivos
	(visible_from objective0 waypoint0)
	(visible_from objective0 waypoint1)
	(visible_from objective0 waypoint2)
	(visible_from objective0 waypoint3)
	(visible_from objective1 waypoint0)
	(visible_from objective1 waypoint1)
	(visible_from objective1 waypoint2)
)

(:goal (and
   (communicated_soil_data waypoint2)
   (communicated_rock_data waypoint3)
   (communicated_image_data objective1 high_res)
   (communicated_image_data objective1 low_res) ; Agrego goal, foto en baja resolucion de objetivo1
   (communicated_image_data objective0 high_res) ; Agrego goal, foto en alta resolucion de objetivo0
   (communicated_image_data objective0 low_res) ; Agrego goal, foto en baja resolucion de objetivo0
   )
)
)
