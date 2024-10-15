// Code your testbench here
// or browse Examples
`include "wb_intf.sv"
`include "spi_intf.sv"
`include "test1"
//`include "wb_spi_env.sv"
//import uvm_pkg::*;
module tb_top;
  bit wb_clk_i;
  bit wb_rst_i;
 

  initial begin
    wb_clk_i =0;
    wb_rst_i=1;
    #1
    wb_rst_i=0;
    $monitor("output values is %0d",spi_int_h.mosi_pad_o);
  end
  
  
  always #5 wb_clk_i=~wb_clk_i;
  
  wb_intf wb_int_h(wb_clk_i,wb_rst_i);
  spi_intf spi_int_h( wb_clk_i);
  initial begin
    uvm_config_db#(virtual spi_intf)::set(uvm_root::get(),"*","spi_vif",spi_int_h);
    uvm_config_db#(virtual wb_intf)::set(uvm_root::get(),"*","wb_vif",wb_int_h);
  end
  /*
  spi_top DUT(
    .wb_clk_i(wb_int_h.wb_clk_i),
    .wb_rst_i(wb_int_h.wb_rst_i),
    .wb_adr_i(10000),
    .wb_dat_i(16383),
    .wb_dat_o(wb_int_h.wb_dat_o),
    .wb_sel_i(11),
    .wb_we_i (0),
    .wb_stb_i(1),
    .wb_cyc_i(1),	
    .wb_ack_o(wb_int_h.wb_ack_o),
    .wb_err_o(wb_int_h.wb_err_o),
    .wb_int_o(wb_int_h.wb_int_o),
    .ss_pad_o(spi_int_h.ss_pad_o),
    .sclk_pad_o(spi_int_h.sclk_pad_o),
    .mosi_pad_o(spi_int_h.mosi_pad_o),
    .miso_pad_i(185),
    .*
    );
 */ 
  spi_top DUT(
    .wb_clk_i(wb_int_h.wb_clk_i),
    .wb_rst_i(wb_int_h.wb_rst_i),
    .wb_adr_i(wb_int_h.wb_adr_i),
    .wb_dat_i(wb_int_h.wb_dat_i),
    .wb_dat_o(wb_int_h.wb_dat_o),
    .wb_sel_i(wb_int_h.wb_sel_i),
    .wb_we_i (wb_int_h.wb_we_i),
    .wb_stb_i(wb_int_h.wb_stb_i),
    .wb_cyc_i(wb_int_h.wb_cyc_i),
    .wb_ack_o(wb_int_h.wb_ack_o),
    .wb_err_o(wb_int_h.wb_err_o),
    .wb_int_o(wb_int_h.wb_int_o),
    .ss_pad_o(spi_int_h.ss_pad_o),
    .sclk_pad_o(spi_int_h.sclk_pad_o),
    .mosi_pad_o(spi_int_h.mosi_pad_o),
    .miso_pad_i(spi_int_h.miso_pad_i),
    .*
    );
  initial begin
    
    $dumpfile("dump.vcd"); 
    $dumpvars;
      #50000;
      $finish;
    end
    initial
    begin
      run_test("test1");
    end

endmodule