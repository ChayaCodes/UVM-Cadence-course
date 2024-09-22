/*-----------------------------------------------------------------
File name     : run.f
Developers    : chaya kremer
Created       : 19/09/24
Description   : simulator run file
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/
// 64 bit option required for AWS labs
-64

-uvmhome $UVMHOME

// include directories
-incdir ../sv

// options
+UVM_VERBOSITY=UVM_HIGH

// (un)comment lines to select test

//+UVM_TESTNAME=exhaustive_seq_test
//+UVM_TESTNAME=short_packet_test
//+UVM_TESTNAME=incr_payload_test
//+UVM_TESTNAME=exhaustive_seq_test
+UVM_TESTNAME=yapp_012_test

+SVSEED=random 

+UVM_NO_RELNOTES


// default timescale
-timescale 1ns/1ns

// compile files
// UVC package
../sv/yapp_pkg.sv

// UVC interfaces
../sv/yapp_if.sv 

// clock generator module
clkgen.sv
// top module for UVM test environment
tb_top.sv
// accelerated top module for interface instance
//hw_top_no_dut.sv
hw_top.sv
// router RTL
../../router_rtl/yapp_router.sv
