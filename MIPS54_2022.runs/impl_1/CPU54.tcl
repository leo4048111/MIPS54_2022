proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir D:/Projects/Vivado/MIPS54_2022/MIPS54_2022.cache/wt [current_project]
  set_property parent.project_path D:/Projects/Vivado/MIPS54_2022/MIPS54_2022.xpr [current_project]
  set_property ip_repo_paths d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.cache/ip [current_project]
  set_property ip_output_repo d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet D:/Projects/Vivado/MIPS54_2022/MIPS54_2022.runs/synth_1/CPU54.dcp
  add_files -quiet D:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0.dcp
  set_property netlist_only true [get_files D:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0.dcp]
  add_files -quiet d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/ila_0/ila_0.dcp
  set_property netlist_only true [get_files d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/ila_0/ila_0.dcp]
  add_files -quiet d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_1/dist_mem_gen_1.dcp
  set_property netlist_only true [get_files d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_1/dist_mem_gen_1.dcp]
  read_xdc -mode out_of_context -ref dist_mem_gen_0 -cells U0 d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0_ooc.xdc
  set_property processing_order EARLY [get_files d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0_ooc.xdc]
  read_xdc -mode out_of_context -ref ila_0 -cells inst d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc
  set_property processing_order EARLY [get_files d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc]
  read_xdc -ref ila_0 -cells inst d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/ila_0/ila_v6_1/constraints/ila.xdc
  set_property processing_order EARLY [get_files d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/ila_0/ila_v6_1/constraints/ila.xdc]
  read_xdc -mode out_of_context -ref dist_mem_gen_1 -cells U0 d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_1/dist_mem_gen_1_ooc.xdc
  set_property processing_order EARLY [get_files d:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/sources_1/ip/dist_mem_gen_1/dist_mem_gen_1_ooc.xdc]
  read_xdc D:/Projects/Vivado/MIPS54_2022/MIPS54_2022.srcs/constrs_1/new/tb.xdc
  link_design -top CPU54 -part xc7a100tcsg324-1
  write_hwdef -file CPU54.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force CPU54_opt.dcp
  report_drc -file CPU54_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force CPU54_placed.dcp
  report_io -file CPU54_io_placed.rpt
  report_utilization -file CPU54_utilization_placed.rpt -pb CPU54_utilization_placed.pb
  report_control_sets -verbose -file CPU54_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force CPU54_routed.dcp
  report_drc -file CPU54_drc_routed.rpt -pb CPU54_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file CPU54_timing_summary_routed.rpt -rpx CPU54_timing_summary_routed.rpx
  report_power -file CPU54_power_routed.rpt -pb CPU54_power_summary_routed.pb -rpx CPU54_power_routed.rpx
  report_route_status -file CPU54_route_status.rpt -pb CPU54_route_status.pb
  report_clock_utilization -file CPU54_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force CPU54.mmi }
  write_bitstream -force CPU54.bit 
  catch { write_sysdef -hwdef CPU54.hwdef -bitfile CPU54.bit -meminfo CPU54.mmi -file CPU54.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

