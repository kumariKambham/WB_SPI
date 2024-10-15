class wb_sequence2 extends uvm_sequence#(wb_seq_item);
  
  rand bit [31:0] data;
  constraint d {data inside {'h5,'h6,'h4,'h3};}
   
  `uvm_object_utils(wb_sequence2)
  
  function new(string name="wb_sequence2");
    super.new(name);
    
  endfunction
  
 
  
  virtual task body();
    repeat (1) begin
    begin
     
   req = wb_seq_item::type_id::create("req");
      //constraint c { req.wb_dat_i inside{ 50,60} ;}
    start_item(req);
    //  req.wb_dat_i[31:0] = $urandom_range(20,50);
      if (!req.randomize() with {req.wb_adr_i == 5'b01100;
                                 req.wb_sel_i==4'b1111;
                                req.wb_we_i==1;
                                req.wb_stb_i==1;
                                 req.wb_cyc_i == 1;})
      begin
        `uvm_error(get_type_name(), "Randomization failure")
      end
  
      `uvm_info(get_type_name(),$sformatf("-------------------------------Inside wb sequence2 req=%0p----------------------",req.wb_dat_i),UVM_NONE);
 
    finish_item(req);
  
    
    end
    end
  endtask
endclass
