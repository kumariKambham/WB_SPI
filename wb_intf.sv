interface wb_intf(input logic wb_clk_i, wb_rst_i);
   /*logic wb_clk_i;
  assign wb_clk_i=clock;
  logic wb_rst_i;*/
  logic [4:0]wb_adr_i;//=5'b10100;
  logic [31:0]wb_dat_i;//=384;
  logic [31:0]wb_dat_o;
  logic [3:0]wb_sel_i;//= 4'b11;
  logic wb_we_i;//=1;
  logic wb_stb_i;// =1;
  logic wb_cyc_i;//=1;
  logic wb_ack_o;
  logic wb_err_o;
  logic wb_int_o;
  

  
  
  clocking wb_driver_cb @(posedge wb_clk_i);
    default  input #1 output #2;
    output wb_adr_i;
    output wb_dat_i;
    output wb_sel_i;
    output wb_we_i;
    output wb_stb_i;
    output wb_cyc_i;
    input  wb_ack_o;
  endclocking
  
    clocking wb_mon_cb @(posedge wb_clk_i);
   
      default input #1 output #0;
      input wb_rst_i;
      input wb_adr_i;
      input wb_dat_o;
      input wb_dat_i;
      input wb_ack_o;
      input wb_stb_i;
      input wb_cyc_i;
      input wb_we_i;
      input wb_sel_i;
      input wb_int_o; 
 
  endclocking

  
    
    
  
 // constraint addr{wb_adr_i inside {10000};}
endinterface