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

+UVM_TESTNAME=exhaustive_seq_test
//+UVM_TESTNAME=short_packet_test
//+UVM_TESTNAME=incr_payload_test
//+UVM_TESTNAME=exhaustive_seq_test
+SVSEED=random 

+UVM_NO_RELNOTES
// compile files
../sv/yapp_pkg.sv
top.sv

