###### Pre-Layout PrimeTime Script #######
## Define the library location
set LIBRARY_HOME "../../../library_32nm/SAED32_EDK" ;# Parent home for synopsys libraries 

set LOGICAL_LIBRARY_PATH  "$LIBRARY_HOME/lib/stdcell_rvt/db_nldm " ;#  Additional search path to be added to the default search path

set TARGET_LIBRARY_FILES      "saed32rvt_ss0p95v125c.db"  ;#  Target technology logical libraries

## Give the path to the verilog files and update library files
set_app_var search_path "${LOGICAL_LIBRARY_PATH} $search_path"
set_app_var target_library ${TARGET_LIBRARY_FILES}
set_app_var link_library "* $target_library"

## read the verilog files
read_verilog ../../dc_synth/clk_gating/output/clk_gating_HDL.v
## Set top module name
current_design data_driven_new

## Read in SDC from the synthesis
source ../../dc_synth/clk_gating/const/clk_gating.sdc

## Analysis reports


report_timing -from [all_inputs] -max_paths 20 -to [all_registers -data_pins]  > reports/timing.rpt
report_timing -from [all_register -clock_pins] -max_paths 20 -to [all_registers -data_pins] > reports/su.timing.rpt
report_timing -from [all_register -clock_pins] -max_paths 20 -to [all_registers -data_pins] -delay_type min > reports/hold.timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 20 -to [all_outputs] >> reports/timing.rpt
report_timing -from [all_inputs] -to [all_outputs] -max_paths 20 >> reports/timing.rpt
report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type max  >> reports/timing.rpt
report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type min  >> reports/timing.rpt
## we add this command for timing reports
report_timing \
  -delay_type max \
  -max_paths 20 \
  -slack_lesser_than 1000 \
  > reports/timing.rpt

report_timing \
  -delay_type min \
  -max_paths 20 \
  -slack_lesser_than 1000 \
  >> reports/timing.rpt
## upto this


report_timing -transition_time -capacitance -nets -input_pins -from [all_registers -clock_pins] -to [all_registers -data_pins]  > reports/timing.tran.cap.rpt


## Save outputs
save_session output/clk_gating.session

