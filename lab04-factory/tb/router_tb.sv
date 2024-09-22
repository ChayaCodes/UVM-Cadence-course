class router_tb extends uvm_env;

    `uvm_component_utils(router_tb)

    yapp_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_int::set(this, "*", "recording_detil", 1);
        `uvm_info("MSG", "the build phase function was executed", UVM_HIGH)
        env = yapp_env::type_id::create("yapp_env", this);
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_name(), "start of simulation for " + get_full_name(), UVM_HIGH)
    endfunction: start_of_simulation_phase

    function void check_phase(uvm_phase phase);
        check_config_usage();
    endfunction: check_phase
    
    


endclass //router_tb extends uvm_env

