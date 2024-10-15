interface spi_intf(input bit clk);
  logic wb_clk_i=clk;
  //assign wb_clk_i=clk;
  logic [7:0]ss_pad_o;
  logic sclk_pad_o;
  logic mosi_pad_o;
  logic miso_pad_i;
  //logic [5:0] spi_pkt_len;
  bit data_array[$];
  
  //data_array.push_front(0);
  
  clocking spi_driver_cb @(posedge wb_clk_i);
    default  input #1 output #2;
    output miso_pad_i;
    input sclk_pad_o;
    output wb_clk_i;
   // output wb_sel_i;
    //output wb_we_i;
    
  endclocking
endinterface