/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

// Define your enumerated type(s) here
typedef enum bit { GOOD_PARITY, BAD_PARITY } parity_t;

class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:

  // Define protocol data

  rand bit [5:0]  length;
  rand bit [1:0] addr;
  rand bit [7:0] payload [];
  bit [7:0] parity;


  // Define control knobs

  rand parity_t parity_type;
  rand int packet_delay;


  // Enable automation of the packet's fields

  `uvm_object_utils_begin(yapp_packet)
    `uvm_field_int(length, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_array_int(payload, UVM_ALL_ON)
    `uvm_field_int(parity, UVM_ALL_ON + UVM_BIN)
    `uvm_field_enum(parity_t, parity_type, UVM_ALL_ON)
    `uvm_field_int(packet_delay, UVM_ALL_ON + UVM_NOCOMPARE)
  `uvm_object_utils_end

  // Define packet 
  
  constraint payload_size {payload.size() == length;}
  constraint default_length {length > 0; length < 64;}
  constraint default_delay {packet_delay >= 0;packet_delay <= 20;}
  constraint default_addr {addr != 'b11;}
  constraint defualt_parity{parity_type dist{BAD_PARITY:=1, GOOD_PARITY:=5};}

  // Add methods for parity calculation and class construction


  function new(string name = "yapp_packet");
    super.new(name);
  endfunction

  function bit [7:0] calc_parity();
    bit [7:0] parity = 0;
    foreach (payload[i]) begin
      parity ^= payload[i];
    end
    return parity;
  endfunction

  function void set_parity();
    parity = calc_parity();
    if(parity_type==BAD_PARITY)
      parity++;
  endfunction

  function void post_randomize();
    set_parity();
  endfunction



endclass: yapp_packet
