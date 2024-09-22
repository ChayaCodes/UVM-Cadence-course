class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    router_tb tb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase", "default_sequence", yapp_5_packets::type_id::get());
        uvm_config_int::set(this, "*", "recording_detail", 1);
        tb = router_tb::type_id::create("tb", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_name(), "start of simulation for " + get_full_name(), UVM_HIGH)
    endfunction: start_of_simulation_phase
    
endclass //base_test extends uvm_test

class short_packet_test extends base_test;
    
    `uvm_component_utils(short_packet_test)


    function new(string name = "short_packet_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        yapp_packet::type_id::set_type_override(short_yapp_packet::get_type());
        super.build_phase(phase);
    endfunction: build_phase
    
endclass

class set_config_test extends base_test;

    `uvm_component_utils(set_config_test)

    function new(string name = "set_config_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        uvm_config_int::set(this, "tb.yapp_env.yapp_agent", "is_active", UVM_PASSIVE);
        super.build_phase(phase);
        
    endfunction: build_phase

    
endclass