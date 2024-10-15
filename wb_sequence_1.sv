class wb_sequence1 extends uvm_sequence#(wb_seq_item);
  
  rand bit [31:0] data;
  constraint d {data inside {'h5,'h6,'h4,'h3};}
   
  `uvm_object_utils(wb_sequence1)
  
  function new(string name="wb_sequence1");
    super.new(name);
    
  endfunction
  
 
  
  virtual task body();
    //repeat (1) begin
    begin
     req = wb_seq_item::type_id::create("req");
      //constraint c { req.wb_dat_i inside{ 50,60} ;}
   /* start_item(req);
    //  req.wb_dat_i[31:0] = $urandom_range(20,50);
      if (!req.randomize() with {req.wb_adr_i == 5'b01100;
                                 req.wb_dat_i== 399;
                                 req.wb_sel_i==4'b1111;
                                req.wb_we_i==1;
                                req.wb_stb_i==1;
                                 req.wb_cyc_i == 1;})
      begin
        `uvm_error(get_type_name(), "Randomization failure")
      end
  
      `uvm_info(get_type_name(),$sformatf("-------------------------------Inside wb sequence2 req=%0p----------------------",req.wb_dat_i),UVM_NONE);
 
    finish_item(req);*/
       start_item(req);                       
      
                req.wb_adr_i       = 5'h00;
      			req.wb_sel_i=4'b1111;
                                req.wb_we_i=1;
                                req.wb_stb_i=1;
                                 req.wb_cyc_i = 1;
                req.wb_dat_i[31:0] = $urandom();
       finish_item(req); 
      
           start_item(req); 
          req.wb_adr_i       = 5'h04;
      			req.wb_dat_i[63:32] = $urandom();
     				req.wb_sel_i=4'b1110;
                                req.wb_we_i=1;
                                req.wb_stb_i=1;
                                 req.wb_cyc_i = 1;
           finish_item(req); 
           start_item(req); 
                  req.wb_adr_i       = 5'h8;
                  req.wb_dat_i[95:64] = $urandom();
     				req.wb_sel_i=4'b1111;
                                req.wb_we_i=1;
                                req.wb_stb_i=1;
                                 req.wb_cyc_i = 1;
           finish_item(req); 
      start_item(req);
          req.wb_adr_i       = 5'h0c;
      for(int i=96; i<127 ;i++)
                     begin
                      req.wb_dat_i[i] = $urandom_range(0,1);
                     end
      for(int i=127;i<128 ;i++)
                     begin
                      req.wb_dat_i[i] = 1'b0;
                     end
                     finish_item(req);
           
  
   // end
    end
  endtask
endclass
