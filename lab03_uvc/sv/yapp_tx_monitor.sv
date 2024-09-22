class yapp_tx_monitor extends uvm_monitor;

    `uvm_component_utils(yapp_tx_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_name(), "start of simulation for" + get_full_name(), UVM_HIGH)
        
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info("MSG", "runing yapp_tx_monitor run_phase", UVM_LOW)
    endtask
endclass //yapp_tx_monitor extends uvm_monitor