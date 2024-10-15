class spi_monitor extends uvm_monitor;
  `uvm_component_utils(spi_monitor)
  virtual spi_intf spi_vif;
  bit array[$];
  uvm_analysis_port #(spi_seq_item) spi_item_collected_port;
  spi_seq_item trans_collected;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
    trans_collected=new();
    spi_item_collected_port=new("item_collected_port",this);
  endfunction
  
  function void  build_phase (uvm_phase phase);
    super.build_phase(phase);
    if(! uvm_config_db #(virtual spi_intf)::get(this,"","spi_vif",spi_vif))
      `uvm_fatal(get_full_name(),"please set spi monitor interface");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(negedge spi_vif.sclk_pad_o);
    trans_collected.mosi_pad_o <=spi_vif.mosi_pad_o;
     
     // array.push_back(spi_vif.mosi_pad_o);
      array.push_back(spi_vif.miso_pad_i);
    spi_item_collected_port.write(trans_collected);
   // end
   // `uvm_info(get_type_name(),$sformatf("-------------------------------Inside spi monitor,spi_data_in=%0d,%0p----------------------",trans_collected.miso_pad_i,array),UVM_NONE);
    end
  endtask
endclass