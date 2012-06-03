(:domain capture_and_hold
  // ========================================================================
  // CAPTURE_AND_HOLD
  // ========================================================================
  (:learnable-method (capture_and_hold)
    (  branch_steam_roll
      (
      )
      (    (steam_roll)
      )
    )
    
    (  branch_capture_and_split
      (
      )
      (    (capture_and_split)
      )
    )
        
    (  branch_divide_and_conquer
      (
      )
      (    (divide_and_conquer)
      )
    )
  )

  // ========================================================================
  // CREATE_SQUADS
  // ========================================================================
  (:method (create_squads ?inp_distribution ?inp_sum)
    (  branch_squads_created
      (and  (call eq (call get_list_length ?inp_distribution) 0)
      )
      (
      )
    )
    
    (  branch_create_squad
      (and  (player_list ?player_list)
          (= ?nr_players (call get_list_length ?player_list))
          (= ?normalized_size (call div (call get_list_item ?inp_distribution 0) ?inp_sum))
          (= ?size (call mul ?nr_players ?normalized_size))
          (= ?distribution (call remove_list_item ?inp_distribution 0))
          (call create_squad)
          (= ?squad_index (call get_last_created_squad))
          (= ?squad (call get_squad ?squad_index))
      )
      (    (add_players ?player_list ?size ?squad_index)
          (!start_command_sequence ?squad 2 1)
          (!order_squad_custom ?squad start_new_operation)
          (create_squads ?distribution (call get_list_sum ?distribution))
      )
    )
  )
  
  // ========================================================================
  // ADD_PLAYERS
  // ========================================================================
  (:method (add_players ?inp_player_list ?inp_size ?inp_squad_index)
    (  branch_players_added
      (or    (call eq (call get_list_length ?inp_player_list) 0)
          (call lt ?inp_size 1.0)
      )
      (
      )
    )
    
    (  branch_add_player
      (and  (= ?player_index (call get_list_item ?inp_player_list 0))
          (= ?player_list (call remove_list_item ?inp_player_list 0))
          (call add_member ?inp_squad_index ?player_index)
      )
      (    (add_players ?player_list (call dec ?inp_size) ?inp_squad_index)
      )
    )
  )
  
  // ========================================================================
  // STRATEGY
  // ========================================================================
  // CAPTURE_AND_SPLIT (3*2*1 permutations)
  // ========================================================================
  (:learnable-method (capture_and_split)
    (  branch_area_sequence_012_distribution_122
      (
      )
      (    (create_squads (1.0 2.0 2.0) 5.0)
          (assign_areas (0 1 2))
      )
    )
    (  branch_area_sequence_201_distribution_212
      (
      )
      (    (create_squads (2.0 1.0 2.0) 5.0)
          (assign_areas (2 0 1))
      )
    )
    (  branch_area_sequence_120_distribution_311
      (
      )
      (    (create_squads (3.0 1.0 1.0) 5.0)
          (assign_areas (1 2 0))
      )
    )
    (  branch_area_sequence_210_distribution_111
      (
      )
      (    (create_squads (1.0 1.0 1.0) 3.0)
          (assign_areas (2 1 0))
      )
    )
    (  branch_area_sequence_102_distribution_211
      (
      )
      (    (create_squads (2.0 1.0 1.0) 4.0)
          (assign_areas (1 0 2))
      )
    )
    (  branch_area_sequence_021_distribution_311
      (
      )
      (    (create_squads (3.0 1.0 1.0) 5.0)
          (assign_areas (0 2 1))
      )
    )
  )
  
  // ========================================================================
  // ASSIGN_AREAS
  // ========================================================================
  (:method (assign_areas ?inp_area_sequence)
    (  branch_areas_assigned
      (and  (call eq (call get_list_length ?inp_area_sequence) 0)
      )
      (
      )
    )
    
    (  branch_assign_area_to_squads
      (and  (= ?area_index (call get_list_item ?inp_area_sequence 0))
          (= ?sequence (call remove_list_item ?inp_area_sequence 0))
          (= ?squad (call get_squad ?area_index))
      )
      (    (assign_area ?area_index ?inp_area_sequence)
          (assign_areas ?sequence)
      )
    )
  )

  // ========================================================================
  // ASSIGN_AREA                         
  // ========================================================================
  (:method (assign_area ?inp_area_index ?inp_squad_list)
    (  branch_area_assigned
      (and  (call eq (call get_list_length ?inp_squad_list) 0)
      )                              
      (                              
      )                              
    )                                  

    (  branch_capture_and_hold        
      (and  (= ?squad_index (call get_list_item ?inp_squad_list 0))
          (call eq ?squad_index ?inp_area_index)
          (= ?squad_list (call remove_list_item ?inp_squad_list 0))
          (= ?squad (call get_squad ?squad_index))
      )
      (    // order clear area filter
          (!order_squad_custom ?squad announce destination_waypoint (call get_area_waypoint ?inp_area_index))
          (!order_squad_custom ?squad defend (call get_area_marker ?inp_area_index) 0)
          // order clear area filter
          (!order_squad_custom ?squad advance (call get_area_waypoint ?inp_area_index) auto)
          (!end_command_sequence ?squad)
          (assign_area ?inp_area_index ?squad_list)
      )
    )

    (  branch_capture_and_move_on
      (and  (= ?squad_index (call get_list_item ?inp_squad_list 0))
          (= ?squad_list (call remove_list_item ?inp_squad_list 0))
          (= ?squad (call get_squad ?squad_index))
      )
      (    // order clear area filter
          (!order_squad_custom ?squad announce destination_waypoint (call get_area_waypoint ?inp_area_index))
          (!order_squad_custom ?squad capture (call get_area_marker ?inp_area_index))
          // order clear area filter
          (!order_squad_custom ?squad advance (call get_area_waypoint ?inp_area_index) auto)
          (assign_area ?inp_area_index ?squad_list)
      )
    )
  )

  // ========================================================================
  // STRATEGY
  // ========================================================================
  // DIVIDE_AND_CONQUER
  // ========================================================================
  (:learnable-method (divide_and_conquer)
    (  branch_squad_distribution_111
      (
      )
      (    (create_squads (1.0 1.0 1.0) 3.0)
          (defend_areas (0 1 2))
      )
    )
    (  branch_squad_distribution_211
      (
      )
      (    (create_squads (2.0 1.0 1.0) 4.0)
          (defend_areas (0 1 2))
      )
    )
    (  branch_squad_distribution_121
      (
      )
      (    (create_squads (1.0 2.0 1.0) 4.0)
          (defend_areas (0 1 2))
      )
    )
  )
  
  // ========================================================================
  // DEFEND_AREAS                         
  // ========================================================================
  (:method (defend_areas ?inp_area_list)
    (  branch_areas_defended
      (and  (call eq (call get_list_length ?inp_area_list) 0)
      )
      (
      )
    )
    
    (  branch_defend_area
      (and  (= ?area_index (call get_list_item ?inp_area_list 0))
          (= ?area_list (call remove_list_item ?inp_area_list 0))
          (= ?squad (call get_squad ?area_index))
      )
      (    (!order_squad_custom ?squad start_new_operation)
          // order clear area filter
          (!order_squad_custom ?squad announce destination_waypoint (call get_area_waypoint ?area_index))
          (!order_squad_custom ?squad defend (call get_area_marker ?area_index) 0)
          // order clear area filter
          (!order_squad_custom ?squad advance (call get_area_waypoint ?area_index) auto)
          (!end_command_sequence ?squad)
          (defend_areas ?area_list)
      )
    )
  )

  // ========================================================================
  // STRATEGY
  // ========================================================================
  // STEAM_ROLL
  // ========================================================================
  (:learnable-method (steam_roll)
    (  branch_area_sequence_012_distribution_1
      (
      )
      (    (create_squads (1.0) 1.0)
          (capture_areas (0 1 2))
      )
    )
    (  branch_area_sequence_201_distribution_1
      (
      )
      (    (create_squads (1.0) 1.0)
          (capture_areas (2 0 1))
      )
    )
    (  branch_area_sequence_120_distribution_1
      (
      )
      (    (create_squads (1.0) 1.0)
          (capture_areas (1 2 0))
      )
    )
    (  branch_area_sequence_210_distribution_1
      (
      )
      (    (create_squads (1.0) 1.0)
          (capture_areas (2 1 0))
      )
    )
    (  branch_area_sequence_102_distribution_1
      (
      )
      (    (create_squads (1.0) 1.0)
          (capture_areas (1 0 2))
      )
    )
    (  branch_area_sequence_021_distribution_1
      (
      )
      (    (create_squads (1.0) 1.0)
          (capture_areas (0 2 1))
      )
    )  
  )
  
  // ========================================================================
  // CAPTURE_AREAS                         
  // ========================================================================
  (:method (capture_areas ?inp_area_list)
    (  branch_areas_captured
      (and  (call eq (call get_list_length ?inp_area_list) 0)
          (= ?squad_index (call get_last_created_squad))
          (= ?squad (call get_squad ?squad_index))
      )
      (    (!end_command_sequence ?squad)
      )
    )
    
    (  branch_capture_area
      (and  (= ?area_index (call get_list_item ?inp_area_list 0))
          (= ?area_list (call remove_list_item ?inp_area_list 0))
          (= ?squad_index (call get_last_created_squad))
          (= ?squad (call get_squad ?squad_index))
      )
      (    (!order_squad_custom ?squad announce destination_waypoint (call get_area_waypoint ?area_index))
          (!order_squad_custom ?squad capture (call get_area_marker ?area_index))
          // order clear area filter
          (!order_squad_custom ?squad advance (call get_area_waypoint ?area_index) auto)
          (capture_areas ?area_list)
      )
    )
  )
)
