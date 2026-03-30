###########################################################################
### Clock Tree Synthesis
###########################################################################
set sh_output_log_file "logs/cts.log"
clock_opt -only_cts


save_mw_cel -as clk_gating_cts
set icc_snapshot_storage_location  "reports" ;# This setting is needed when default snapshot directory is not available 
report_placement_utilization > reports/fifo_cts_util.rpt
report_qor_snapshot > reports/fifo_cts_qor_snapshot.rpt
report_qor > reports/fifo_cts_qor.rpt
report_timing -max_paths 20 -delay max > reports/fifo_cts.setup.rpt
report_timing -max_paths 20 -delay min > reports/fifo_cts.hold.rpt

