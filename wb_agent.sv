`include "wb_seq_item.sv"
`include "cntr_reg_sequence.sv"
`include "wb_sequence.sv"
`include "wb_sequence_2.sv"
`include "wb_sequence_1.sv"
`include "wb_sequence_3.sv"
`include "wb_seqr.sv"
`include "wb_driver.sv"
`include "wb_monitor.sv"
class wb_agent extends uvm_agent;
  `uvm_component_utils(wb_agent)
  wb_driver driver_h;
  wb_seqr seqr_h;
  wb_monitor mon_h;
  function new(string name="wb_agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver_h=wb_driver::type_id::create("driver_h",this);
    seqr_h  =wb_seqr::type_id::create("seqr_h",this);
    mon_h   =wb_monitor::type_id::create("mon_h",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"-------------------------------Inside wb agent----------------------",UVM_NONE);
    driver_h.seq_item_port.connect(seqr_h.seq_item_export);
    
  endfunction
    
endclass