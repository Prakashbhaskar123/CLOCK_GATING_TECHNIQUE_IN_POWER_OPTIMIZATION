###########################################################################
### Placement
###########################################################################


set sh_output_log_file "logs/place.log"
set_buffer_opt_strategy -effort low

set_tlu_plus_files -max_tluplus $LIBRARY_HOME/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus -min_tluplus $LIBRARY_HOME/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus  -tech2itf_map $LIBRARY_HOME/tech/star_rcxt/saed32nm_tf_itf_tluplus.map


place_opt -congestion

save_mw_cel -as clk_gating_place

### Reports 

write_def -output output/clk_gating_place.def
report_placement_utilization > output/clk_gating_place_util.rpt
report_qor_snapshot > output/clk_gating_place_qor_snapshot.rpt
report_qor > output/clk_gating_place_qor.rpt

### Timing Report

report_timing -delay max -max_paths 20 > output/clk_gating_place.setup.rpt
##set_case_analysis 1 scanEn
report_timing -delay min -max_paths 20 > output/clk_gating_place.hold.rpt
