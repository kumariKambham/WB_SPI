//`include "wb_sequence.sv"
`define DRIV_IF wb_vif.wb_driver_cb
class wb_driver extends uvm_driver#(wb_seq_item);
  `uvm_component_utils(wb_driver)
  
  function new(string name="wb_driver", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  virtual wb_intf wb_vif;
 // wb_seq_tem seq_item;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(! uvm_config_db#(virtual wb_intf)::get(this,"","wb_vif",wb_vif))
    `uvm_fatal(get_full_name(),"please set interface handle")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
   // super.run_phase(phase);
    `uvm_info(get_type_name(),"-------------------------------Inside wb driver----------------------",UVM_NONE);
    forever 
      begin
    seq_item_port.get_next_item(req);
      drive();
      $display("display2------------------");
     #10;seq_item_port.item_done();
    
    end
   // seq_item=wb_seq_item::type_id::create("seq_item");
   // repeat(4)
    //seq_item.randomize();
  endtask
    
    virtual task drive();
      //`uvm_info(get_type_name(),"-------------------------------Inside wb driver----------------------111",UVM_NONE);
      // seq_item_port.get_next_item(req);
     // `uvm_info(get_type_name(),"-------------------------------Inside wb driver2----------------------",UVM_NONE);
      
      $display("inside drive task");
      @(posedge wb_vif.wb_clk_i);
      if(req.reset) begin
        `DRIV_IF.wb_adr_i <=0;//5'b10000;
      `DRIV_IF.wb_dat_i <=0;
      `DRIV_IF.wb_sel_i <=0;
      `DRIV_IF.wb_stb_i <=0;
      `DRIV_IF.wb_cyc_i <=0;
      `DRIV_IF.wb_we_i <=0;
      end
      else if( !req.reset && req.wb_we_i==1)  begin
        `DRIV_IF.wb_adr_i <= req.wb_adr_i;
        `DRIV_IF.wb_sel_i <=4'b1111;//req.wb_sel_i;
      	`DRIV_IF.wb_stb_i <=1'b1;//req.wb_stb_i;
      	`DRIV_IF.wb_cyc_i <=1'b1;//req.wb_cyc_i;
      	`DRIV_IF.wb_we_i  <=1'b1;//req.wb_we_i;
      	
        if(req.wb_adr_i == 'h00)
            begin
              `DRIV_IF.wb_dat_i [31:0] <= req.wb_dat_i[31:0];
            end
            
          else if(req.wb_adr_i  == 'h04)
            begin
              `DRIV_IF.wb_dat_i [31:0] <= req.wb_dat_i[63:32];
            end
            
          else if(req.wb_adr_i  == 'h08)
            begin
              `DRIV_IF.wb_dat_i [31:0] <= req.wb_dat_i[95:64];
            end
            
          else if(req.wb_adr_i  == 'h0c)
            begin
              `DRIV_IF.wb_dat_i [31:0] <= req.wb_dat_i[127:96];
            end
        else if(req.wb_adr_i == 'h10) 
        	begin
      		`DRIV_IF.wb_adr_i <=req.wb_adr_i;
      		`DRIV_IF.wb_dat_i <=req.wb_dat_i;
              
            end
        wait(`DRIV_IF.wb_ack_o ==1'b1 );
            begin
                `DRIV_IF.wb_stb_i <= 1'b0;
                 `DRIV_IF.wb_sel_i <= 4'b0000;
                 `DRIV_IF.wb_cyc_i <= 1'b0;

                /* wait(!`DRIV_IF.wb_ack_o);
              if(req.wb_adr_i == 'h10 && req.wb_dat_i[12] == 1)
                    begin
                    //wait(wb_int.wb_drv_cb.wb_int_o == 1);
                    end */
            end
      end
      else 
      begin
      `DRIV_IF.wb_adr_i <=req.wb_adr_i;
      `DRIV_IF.wb_dat_i <=req.wb_dat_i;        
      `DRIV_IF.wb_sel_i <=req.wb_sel_i;
      `DRIV_IF.wb_stb_i <=req.wb_stb_i;
      `DRIV_IF.wb_cyc_i <=req.wb_cyc_i;
      `DRIV_IF.wb_we_i <=req.wb_we_i;
      end
      
      $display("address =%0h ", req.wb_dat_i, $time);
      req.print();
     // #10;
    //  seq_item_port.item_done();
    endtask
  
endclass