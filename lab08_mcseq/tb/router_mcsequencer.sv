//  Class: router_mcsequencer
//
class router_mcsequencer extends uvm_sequencer;
    
    `uvm_component_utils(router_mcsequencer)

    yapp_tx_sequencer yapp_sequencer;
    hbus_master_sequencer hbus_sequencer;


    function new(string name = "router_mcsequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction


  function void build_phase(uvm_phase phase);
    uvm_config_wrapper::set(this, "tb.yapp_sequencer.run_phase",
                            "default_sequence",
                            yapp_012_seq::get_type());

   super.build_phase(phase);
  endfunction : build_phase

    
    
endclass: router_mcsequencer