#=========================================================================
# 02-synopsys-dc-synth/run.tcl
#=========================================================================

#-------------------------------------------------------------------------
# Initial setup
#-------------------------------------------------------------------------

set_app_var target_library "$env(ECE6745_STDCELLS)/stdcells.db"
set_app_var link_library   "* $env(ECE6745_STDCELLS)/stdcells.db"

#-------------------------------------------------------------------------
# Inputs
#-------------------------------------------------------------------------

analyze -format sverilog $env(TOPDIR)/sim/build/RegIncr4stage__pickled.v
elaborate RegIncr4stage

#-------------------------------------------------------------------------
# Timing constraints
#-------------------------------------------------------------------------

create_clock clk -name ideal_clock1 -period 1

#-------------------------------------------------------------------------
# Synthesis
#-------------------------------------------------------------------------

compile

#-------------------------------------------------------------------------
# Outputs
#-------------------------------------------------------------------------

write -format ddc     -hierarchy -output post-synth.ddc
write -format verilog -hierarchy -output post-synth.v

report_timing -nets      > timing.rpt
report_area   -hierarchy > area.rpt

exit
