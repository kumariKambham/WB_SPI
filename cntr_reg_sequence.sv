class cntr_reg_sequence extends uvm_sequence#(wb_seq_item);
  
  `uvm_object_utils(cntr_reg_sequence)
  
  function new(string name="cntr_reg_sequence");
    super.new(name);
  endfunction
  
 
  
  virtual task body();
    repeat (1) begin
    begin
     
   req = wb_seq_item::type_id::create("req");
    start_item(req);
 
      if (!req.randomize() with {req.wb_adr_i == 5'b10000;
                                 req.wb_we_i == 1; 
                                 req.wb_dat_i[6:0] == 127;
                                 req.wb_dat_i[8] ==1 ; //GO_BSY
                                 req.wb_dat_i[9] ==1 ; //Rx_neg 
                                 req.wb_dat_i[10]==0 ; //TX neg
                                 req.wb_dat_i[11]==1 ;// lsb
                                 req.wb_sel_i==4'b1111;
                                req.wb_we_i==1;
                                req.wb_stb_i==1;
                                 req.wb_cyc_i == 1;})
      begin
        `uvm_error(get_type_name(), "Randomization failure")
      end
     
 
    finish_item(req);
  
    
    end
    end
  endtask
endclass
