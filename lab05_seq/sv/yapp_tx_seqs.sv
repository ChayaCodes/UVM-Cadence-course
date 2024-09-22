/*-----------------------------------------------------------------
File name     : yapp_tx_seqs.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : YAPP UVC simple TX test sequence for labs 2 to 4
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// SEQUENCE: base yapp sequence - base sequence with objections from which 
// all sequences can be derived
//
//------------------------------------------------------------------------------
class yapp_base_seq extends uvm_sequence #(yapp_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_base_seq)

  // Constructor
  function new(string name="yapp_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : yapp_base_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: yapp_5_packets
//
//  Configuration setting for this sequence
//    - update <path> to be hierarchial path to sequencer 
//
//  uvm_config_wrapper::set(this, "<path>.run_phase",
//                                 "default_sequence",
//                                 yapp_5_packets::get_type());
//
//------------------------------------------------------------------------------
class yapp_5_packets extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_5_packets)

  // Constructor
  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask
  
endclass : yapp_5_packets

class yapp_1_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_1_seq)

  function new(string name="yapp_1_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "yapp 1 sequence executeing", UVM_LOW)
    `uvm_do_with(req, {addr == 1;});
  endtask

endclass

class yapp_012_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_012_seq)

  function new(string name = "yapp_012_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "yapp_012_seq executing", UVM_LOW)
    for (int i=0; i<=2; ++i) begin
      `uvm_do_with(req, {addr==i;});
    end
  endtask
endclass

class yapp_111_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_111_seq)

  yapp_1_seq y1s;

  function new(string name = "yapp_111_seq");
    super.new(name);
  endfunction
  

  virtual task body();
    `uvm_info(get_type_name(), "yap_111_seq executing", UVM_LOW)
    repeat(3)
      `uvm_do(y1s);
  endtask
endclass

class yapp_repeat_addr_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_repeat_addr_seq)

  function new(string name = "yapp_repeat_addr_seq ");
    super.new(name);
  endfunction

  rand bit[1:0] seqaddr;
  constraint legal_addr { seqaddr != 3; }

  virtual task body();
    `uvm_info(get_name(), "yapp_repeat_addr_seq executing", UVM_LOW)
    repeat(2)
      `uvm_do_with(req, {addr==seqaddr;});
  endtask
endclass


class yapp_incr_payload_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_incr_payload_seq)

  function new(string name = "yapp_incr_payload_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_name(), "yapp_incr_payload_seq executing", UVM_LOW)
    `uvm_do_with(req, {foreach (payload[i]) payload[i] == i;});
  endtask
endclass

class yapp_exhaustive_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_exhaustive_seq)

  function new(string name = "yapp_exhaustive_seq");
    super.new(name);
  endfunction

  yapp_012_seq y012;
  yapp_1_seq y1;
  yapp_111_seq y111;
  yapp_repeat_addr_seq yaddr;
  yapp_incr_payload_seq yinc;

  virtual task body();
    `uvm_info(get_name(), "yapp_exhaustive_seq body executing", UVM_HIGH)    
    `uvm_do(y012);
    `uvm_do(y1);
    `uvm_do(y111);
    `uvm_do(yaddr);
    `uvm_do(yinc);
  endtask
endclass