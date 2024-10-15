class wb_sequence3 extends uvm_sequence#(wb_seq_item);
  
  rand bit [31:0] data;
  constraint d {data inside {'h5,'h6,'h4,'h3};}
   
  `uvm_object_utils(wb_sequence3)
  
  function new(string name="wb_sequence3");
    super.new(name);
    
  endfunction
  
 
  
  virtual task body();
    //repeat (1) begin
    begin
     req = wb_seq_item::type_id::create("req");
        start_item(req);
        req.reset=1;
        finish_item(req);

 
  
   // end
    end
  endtask
endclass
