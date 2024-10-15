class wb_sequence extends uvm_sequence#(wb_seq_item);
  
  `uvm_object_utils(wb_sequence)
  
  function new(string name="wb_sequence");
    super.new(name);
  endfunction
  
 
  
  virtual task body();
    repeat (1) begin
    begin
       `uvm_info(get_type_name(),"-------------------------------Inside wb sequence----------------------",UVM_NONE);
     req = wb_seq_item::type_id::create("req");
   
      start_item(req);
      
      if (!req.randomize() with {req.wb_adr_i == 5'b00000;
                                req.wb_dat_i==0;
                               req.wb_we_i==0;
                                })
      begin
        `uvm_error(get_type_name(), "Randomization failure")
      end
  
       `uvm_info(get_type_name(),$sformatf("-------------------------------Inside wb sequence req=%0p----------------------",req),UVM_NONE);
 
    finish_item(req);
  
  
  
    
    end
    end
  endtask
endclass
