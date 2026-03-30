###########################################################################
### Floorplanning
###########################################################################

set sh_output_log_file "logs/floorplan.log"
create_floorplan -control_type aspect_ratio -core_aspect_ratio 1 -core_utilization .75  -row_core_ratio 1  -start_first_row -left_io2core 5.0 -bottom_io2core 5.0 -right_io2core 5.0 -top_io2core 5.0 


derive_pg_connection -power_net VDD -ground_net VSS
derive_pg_connection -power_net VDD -ground_net VSS -tie

#preroute_standard_cells  -fill_empty_rows -do_not_route_over_macros -skip_macro_pins \
# -connect horizontal

#create_power_straps  -direction vertical -start_at 0.0 -nets  {VSS VDD} -layer M6 -width 0.3 -configure step_and_stop -step 10 -stop 68.0 -extend_low_ends to_boundary_and_generate_pins -extend_high_ends to_boundary_and_generate_pins


#create_preroute_vias -nets VSS -from_layer M1 -to_layer M6 -from_object_std_pin_connection  -to_object_strap -connect_to_targets_on_all_layers_in_between
## Save the design

set_fp_rail_constraints  -skip_ring -extend_strap boundary

set_fp_rail_constraints -add_layer  -layer M6 -direction vertical \
-max_strap 5 -min_strap 3 -min_width 0.056 -max_width 0.3 -spacing 0.8 -offset 10.01

set_fp_rail_constraints -add_layer  -layer M5 -direction horizontal \
-max_strap 10 -min_strap 6 -min_width 0.05  -max_width 0.2 -spacing 0.5 -offset 5.02

synthesize_fp_rail  -nets {VDD VSS} -synthesize_power_plan \
-use_strap_ends_as_pads \
-voltage_supply 0.95 \
-power_budget 100 \
-target_voltage_drop 50

commit_fp_rail

preroute_standard_cells  -fill_empty_rows -do_not_route_over_macros -skip_macro_pins
 

write_def -output output/clk_gating_fp.def
save_mw_cel -as clk_gating_fp

puts "floorplan done!!!!!"
