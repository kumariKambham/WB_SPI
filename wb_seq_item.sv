
class wb_seq_item extends uvm_sequence_item;
  
  rand bit [4:0]wb_adr_i;
  rand bit [127:0]wb_dat_i;
  rand bit [3:0]wb_sel_i;
  rand bit wb_we_i;
  rand bit wb_stb_i;
  rand bit wb_cyc_i;
  bit [127:0]wb_dat_o;
  bit reset;
  rand bit [7:0]    slv_sel;
          
   constraint slave_range { slv_sel inside{'h01,'h02,'h04,'h08,'h10,'h20,'h40,'h80};}    
  
  //constraint addr{wb_adr_i == 10000;}
  //constraint data{wb_dat_i inside {385,50,60, 'h40};}
  
  `uvm_object_utils_begin(wb_seq_item)
  `uvm_field_int(wb_adr_i,UVM_ALL_ON)
  `uvm_field_int(wb_dat_i,UVM_ALL_ON)
  `uvm_field_int(wb_sel_i,UVM_ALL_ON)
  `uvm_field_int(wb_we_i,UVM_ALL_ON)
  `uvm_field_int(wb_stb_i,UVM_ALL_ON)
  `uvm_field_int(wb_cyc_i,UVM_ALL_ON)
  `uvm_field_int(wb_dat_o,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="wb_seq_item");
    super.new(name);
  endfunction
  
endclass