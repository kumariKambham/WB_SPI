`define DRIV_IF spi_vif.spi_driver_cb
//`define wDRIV_IF wb_vif.wb_mon_cb
class spi_driver extends uvm_driver#(spi_seq_item);
  `uvm_component_utils(spi_driver)
  bit [7:0] l;
  int i=0;
  
  function new(string name="spi_driver", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  virtual spi_intf spi_vif;
   virtual wb_intf wb_vif;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(! uvm_config_db#(virtual spi_intf)::get(this,"","spi_vif",spi_vif))
    `uvm_fatal(get_full_name(),"please set interface handle")
       if(! uvm_config_db#(virtual wb_intf)::get(this,"","wb_vif",wb_vif))
    `uvm_fatal(get_full_name(),"please set interface handle")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever 
      begin
       //seq_item_port.get_next_item(req);
        //wait(spi_vif.sclk_pad_o ==1) begin
          
         // spi_vif.data_array.push_front(0);
          drive(req);
        //end
      // seq_item_port.item_done();
      
    end
  endtask
  
    virtual task drive(spi_seq_item req);
    //begin  
      
      seq_item_port.get_next_item(req);
    req.print();
    //l=5;//req.spi_char_miso_len;
     //  `uvm_info(get_type_name(),$sformatf("-------------------------------spi_char_miso_len=%0d----------------------",l),UVM_NONE);
    $display("inside spi drive task");
   // for(int i=0;i<l;i++) begin
      @(posedge spi_vif.sclk_pad_o) begin
        i=i+1;
        spi_vif.miso_pad_i <=req.miso_pad_i;//data_miso[i];
        spi_vif.data_array.push_back(req.miso_pad_i);
         seq_item_port.item_done();
  // end
        $display("address in spi_driver %0d and array=%0p and i=%0d",req.miso_pad_i,spi_vif.data_array,i);
    end
    
     
  endtask
    
endclass