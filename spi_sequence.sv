class spi_sequence extends uvm_sequence#(spi_seq_item);
  
  `uvm_object_utils(spi_sequence)
  
  function new(string name="spi_sequence");
    super.new(name);
  endfunction
  
 
  
  virtual task body();
    repeat(127)  begin
    begin
      `uvm_info(get_type_name(),"-------------------------------Inside spi sequence----------------------",UVM_NONE);
     req = spi_seq_item::type_id::create("req");
    start_item(req);
      if (!req.randomize())
      begin
        `uvm_error(get_type_name(), "Randomization failure")
      end
   
      `uvm_info(get_type_name(),$sformatf("-------------------------------Inside spi sequence req=%0p----------------------",req),UVM_NONE);
  
        req.print();
    finish_item(req);
      
    end
    end
  endtask
endclass