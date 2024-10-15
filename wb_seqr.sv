class wb_seqr extends uvm_sequencer#(wb_seq_item);
  
  `uvm_component_utils(wb_seqr)
  
  function new(string name="wb_seqr",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
endclass