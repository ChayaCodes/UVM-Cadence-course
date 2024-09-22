class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    router_tb tb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase", "default_sequence", yapp_5_packets::type_id::get());
        tb = new("tb", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_name(), "start of simulation for " + get_full_name(), UVM_HIGH)
    endfunction: start_of_simulation_phase
    
endclass //base_test extends uvm_test