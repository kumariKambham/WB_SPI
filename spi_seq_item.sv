class spi_seq_item extends uvm_sequence_item;
  `uvm_object_utils(spi_seq_item)
  bit [7:0]ss_pad_o;
  bit sclk_pad_o;
  bit mosi_pad_o;
  rand bit miso_pad_i;
  bit [7:0] spi_char_miso_len=6;
  //bit [127:0] data_miso ;
  
  
 /* `uvm_object_utils_begin(spi_seq_item)
  `uvm_field_int(ss_pad_o,UVM_ALL_ON)
  `uvm_field_int(sclk_pad_o,UVM_ALL_ON)
  `uvm_field_int(mosi_pad_o,UVM_ALL_ON)
  `uvm_field_int(miso_pad_i,UVM_ALL_ON)
  `uvm_object_utils_end
  */
  
  function new(string name="spi_seq_item");
    super.new(name);
  endfunction
  
  
endclass