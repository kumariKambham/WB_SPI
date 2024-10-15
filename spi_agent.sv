`include "spi_seq_item.sv"
`include "spi_sequence.sv"
`include "spi_seqr.sv"
`include "spi_driver.sv"
`include "spi_monitor.sv"
class spi_agent extends uvm_agent;
  `uvm_component_utils(spi_agent)
  
  spi_monitor mon_h;
  spi_seqr seq_h;
  spi_driver driv_h;
  function new(string name="spi_agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_h=spi_monitor::type_id::create("mon_h",this);
    driv_h=spi_driver::type_id::create("driv_h",this);
    seq_h=spi_seqr::type_id::create("seq_h",this);
  endfunction
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     `uvm_info(get_type_name(),"-------------------------------Inside spi agent----------------------",UVM_NONE);
    driv_h.seq_item_port.connect(seq_h.seq_item_export);
    
  endfunction
endclass