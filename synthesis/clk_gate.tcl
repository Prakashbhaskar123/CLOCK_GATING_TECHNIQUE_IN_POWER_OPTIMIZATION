###### Synthesis Script #######
set sh_output_log_file "logs/dc.log"
set LIBRARY_HOME "../../../library_32nm/SAED32_EDK" ;# Parent home for synopsys libraries 

set LOGICAL_LIBRARY_PATH  "${LIBRARY_HOME}/lib/stdcell_rvt/db_nldm " ;#  Additional search path to be added to the default search path

set TARGET_LIBRARY_FILES      "saed32rvt_ss0p95v125c.db"  ;#  Target technology logical libraries

## Give the path to the verilog files and update library files
lappend search_path ../../src/clk_gating
set_app_var search_path "${LOGICAL_LIBRARY_PATH} $search_path"
set_app_var target_library ${TARGET_LIBRARY_FILES}
set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $target_library $synthetic_library"

#########Define the WORK directory
define_design_lib WORK -path "work"

## read the verilog files
analyze -library WORK -format verilog main.v

elaborate   -architecture verilog -library WORK data_driven_new


## Check if design is consistent
check_design  > reports/synth_check_design.rpt

## Create Constraints 
create_clock clk -name ideal_clock1 -period 4
set_input_delay 1.0 [ remove_from_collection [all_inputs] clk] -clock ideal_clock1
set_output_delay 1.0 [all_outputs ] -clock ideal_clock1

set_max_area 0 
set_max_leakage_power 0.0


uniquify


compile -area_effort medium -map_effort high -power_effort high

## Below commands report area , cell, qor, resources, and timing information needed to analyze the design. 

  report_area > reports/synth_area.rpt
  report_design > reports/synth_design.rpt
  report_cell > reports/synth_cells.rpt
  report_qor  > reports/synth_qor.rpt
  report_resources > reports/synth_resources.rpt
  report_timing -max_paths 10 > reports/synth_timing.rpt
  report_power -analysis_effort medium > reports/synth_power.rpt

## Dump out the constraints in an SDC file
  write_sdc const/clk_gating.sdc

## Dump out the synthesized database and gate-level-netlist
  write -f ddc -hierarchy -output output/clk_gating.ddc

  write -hierarchy -format verilog -output  output/clk_gating_HDL.v

