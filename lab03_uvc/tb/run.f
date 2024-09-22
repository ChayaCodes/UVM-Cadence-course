/*-----------------------------------------------------------------
File name     : run.f
Description   : lab01_data simulator run template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
              : Set $UVMHOME to install directory of UVM library
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/


 -uvmhome $UVMHOME

// include directories
//*** add incdir include directories here

// compile files
//*** add compile files here

-incdir ../sv

//options
+UVM_VERBOSITY=UVM_MEDIUM
+UVM_TESTNAME=base_test

../sv/yapp_pkg.sv 
top.sv
