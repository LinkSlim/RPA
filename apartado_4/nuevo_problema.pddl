(define (problem rovers-tow-mission)
(:domain Rover-battery)
(:objects
    ; General
    general - lander
    
    ; Rovers (3 remolcadores, 3 carga)
    r-tow-rock r-tow-sand r-tow-flat - rover
    cargo1 cargo2 cargo3 - rover
    
    ; Waypoints
    centro wp-rocoso wp-arenoso wp-llano - waypoint
    
    ; Baterias y Niveles
    bat-r1 bat-r2 bat-r3 bat-c1 bat-c2 bat-c3 - battery
    l0 l1 l2 l3 l4 l5 - blevel
    
    ; Terrenos y Tracciones
    t-rocoso - traction
    t-arenoso - traction
    t-llano - traction
    y-rocoso - terrain ; 'y' para diferenciar de traccion
    y-arenoso - terrain
    y-llano - terrain
    
    ; Tipos no usados pero requeridos por definicion
    cam1 - camera
    obj1 - objective
    mode1 - mode
    store1 - store
)

(:init
    ; --- Configuracion de Bateria (Orden) ---
    (lower l0 l1) (lower l1 l2) (lower l2 l3) (lower l3 l4) (lower l4 l5)
    
    ; --- Instalacion de Baterias (Todos empiezan llenos l5) ---
    (battery_installed r-tow-rock bat-r1 l5 l5)
    (battery_installed r-tow-sand bat-r2 l5 l5)
    (battery_installed r-tow-flat bat-r3 l5 l5)
    ; Los de carga tambien tienen bateria para existir, aunque no la gasten al ser remolcados
    (battery_installed cargo1 bat-c1 l5 l5)
    (battery_installed cargo2 bat-c2 l5 l5)
    (battery_installed cargo3 bat-c3 l5 l5)
    
    ; --- Configuracion de Tracciones y Terrenos ---
    ; Definir que traccion sirve para que terreno
    (compatible t-rocoso y-rocoso)
    (compatible t-arenoso y-arenoso)
    (compatible t-llano y-llano)
    
    ; Asignar traccion a los rovers remolcadores
    (has_traction r-tow-rock t-rocoso)
    (has_traction r-tow-sand t-arenoso)
    (has_traction r-tow-flat t-llano)
    ; Los rovers de carga NO tienen traccion (forzando a ser remolcados)

    ; --- Mapa y Tipos de Camino ---
    ; Todos empiezan en el centro
    (at r-tow-rock centro)
    (at r-tow-sand centro)
    (at r-tow-flat centro)
    (at cargo1 centro)
    (at cargo2 centro)
    (at cargo3 centro)
    
    ; Visibilidad y Tipo de terreno (Bidireccional)
    ; 1. Camino Rocoso
    (visible centro wp-rocoso) (visible wp-rocoso centro)
    (path_type centro wp-rocoso y-rocoso) (path_type wp-rocoso centro y-rocoso)
    
    ; 2. Camino Arenoso
    (visible centro wp-arenoso) (visible wp-arenoso centro)
    (path_type centro wp-arenoso y-arenoso) (path_type wp-arenoso centro y-arenoso)
    
    ; 3. Camino Llano
    (visible centro wp-llano) (visible wp-llano centro)
    (path_type centro wp-llano y-llano) (path_type wp-llano centro y-llano)
    
    ; --- Estados vacios requeridos por el dominio (Lander, etc) ---
    (at_lander general centro)
    (available r-tow-rock) (available r-tow-sand) (available r-tow-flat)
    (available cargo1) (available cargo2) (available cargo3)
)

(:goal (and
    ; 1. Forzar TOW en terreno ROCOSO
    ; El cargo1 debe llegar a wp-rocoso. Solo r-tow-rock puede llevarlo.
    (at cargo1 wp-rocoso)
    
    ; 2. Forzar TOW en terreno ARENOSO
    ; El cargo2 debe llegar a wp-arenoso. Solo r-tow-sand puede llevarlo.
    (at cargo2 wp-arenoso)
    
    ; 3. Forzar TOW en terreno LLANO
    ; El cargo3 debe llegar a wp-llano. Solo r-tow-flat puede llevarlo.
    (at cargo3 wp-llano)
    
    ; 4. Forzar NAVIGATE-BAT
    ; Despues de dejar a cargo1 en wp-rocoso, el r-tow-rock debe volver al centro.
    ; Esto obliga a r-tow-rock a moverse solo (navigate) por el terreno rocoso de vuelta.
    (at r-tow-rock centro)
))
)