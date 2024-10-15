class wb_monitor extends uvm_monitor;
  `uvm_component_utils(wb_monitor)
  virtual wb_intf wb_vif;
  bit [31:0]array[$];
  uvm_analysis_port #(wb_seq_item) wb_item_collected_port;
  wb_seq_item trans_collected;
  
  function new(string name="wb_monitor", uvm_component parent);
    super.new(name,parent);
    trans_collected=new();
    wb_item_collected_port=new("item_collected_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    
    `uvm_info(get_type_name(),"-------------------------------Inside wb monitor----------------------",UVM_NONE);
    if(!uvm_config_db#(virtual wb_intf)::get(this,"","wb_vif",wb_vif))
      `uvm_fatal(get_full_name(),"please set monitor interface handle");
    
       endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(negedge wb_vif.wb_clk_i);
      trans_collected.wb_dat_i <=wb_vif.wb_dat_i;
    trans_collected.wb_dat_o <= wb_vif.wb_dat_o;
      array.push_back(wb_vif.wb_dat_o);
    wb_item_collected_port.write(trans_collected);
     /* if(wb_vif.wb_dat_o=='h1); begin
        `uvm_info(get_type_name(),$sformatf("-------------------------------Inside wb monitor::::: %0d,---------------------",wb_vif.wb_dat_o),UVM_NONE);end
    */
    
   //   `uvm_info(get_type_name(),$sformatf("-------------------------------Inside wb monitor,wb_data_out=%0p,----------------------",array),UVM_NONE);
    end
  endtask
endclass