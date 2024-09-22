class yapp_tx_agent extends uvm_agent;

    //uvm_active_passive_enum is_active = UVM_ACTIVE;

   

    `uvm_component_utils_begin(yapp_tx_agent)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_component_utils_end

    yapp_tx_sequencer sequencer;
    yapp_tx_monitor monitor;
    yapp_tx_driver driver; 

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor=new("monitor",this);
        if(is_active == UVM_ACTIVE)begin
            driver=new("driver",this);
            sequencer=new("sequencer",this);
        end
    endfunction

    virtual function void phase_connect(uvm_phase phase);
        if(is_active == UVM_ACTIVE)
            driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

endclass