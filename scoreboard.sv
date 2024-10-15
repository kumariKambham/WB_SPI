
`uvm_analysis_imp_decl(_port_w)
`uvm_analysis_imp_decl(_port_s)
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard);
  wb_seq_item wb_pkt[$];
  spi_seq_item spi_pkt[$];
  wb_seq_item w_pkt;
  spi_seq_item s_pkt;
  int count=0;
  int l,len;
  bit output_spi_data[$],x[$];
  bit queue[$];
  
  uvm_analysis_imp_port_w #(wb_seq_item, scoreboard) wb_item_collected_export;
  uvm_analysis_imp_port_s #(spi_seq_item, scoreboard) spi_item_collected_export;

  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
   virtual spi_intf spi_vif;
  virtual wb_intf wb_vif;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wb_item_collected_export = new("wb_item_collected_export", this);
    spi_item_collected_export = new("spi_item_collected_export", this);
    if(! uvm_config_db#(virtual spi_intf)::get(this,"","spi_vif",spi_vif))
    `uvm_fatal(get_full_name(),"please set interface handle")
        if(! uvm_config_db#(virtual wb_intf)::get(this,"","wb_vif",wb_vif))
    `uvm_fatal(get_full_name(),"please set interface handle")
          
  endfunction: build_phase
  
  virtual function void write_port_w(wb_seq_item pkt);
   // $display("SCB:: Pkt recived");
    wb_pkt.push_back(pkt);//.print();
 //   `uvm_info(get_type_name(),$sformatf("-------------------------------Printing wb_pkt=%0p----------------------",wb_pkt),UVM_NONE);
  endfunction 
  virtual function void write_port_s(spi_seq_item pkt);
   // $display("SCB:: Pkt recived");
    spi_pkt.push_back(pkt);//.print();
   // `uvm_info(get_type_name(),$sformatf("-------------------------------Printing spi_pkt=%0p----------------------",s_pkt),UVM_NONE);
  endfunction 
  
  virtual task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
   // fork 
      forever 
        begin
          //spi_vif.data_array.reverse();
          l=spi_vif.data_array.size();
        //  `uvm_info(get_type_name(),$sformatf("----------Length of SPI SERIAL data_array",l),UVM_NONE);
        	wait(wb_pkt.size()>0);
        	w_pkt<=wb_pkt.pop_front();
        //  `uvm_info(get_type_name(),$sformatf("----------wishbone packets %0p",w_pkt),UVM_NONE);
        	if(w_pkt !=null) begin
              //-------------------SPI INPUT _ WISHBONE OUTPUT-------------------------------//
              if(wb_vif.wb_we_i==0 &&l<20 ) begin
               // @(posedge spi_vif.sclk_pad_o) begin
                @(negedge wb_vif.wb_clk_i) begin
                  queue ={>>{w_pkt.wb_dat_o }};
                  
                  `uvm_info(get_type_name(),$sformatf("----------Length of SPI SERIAL data_array=%0p",queue),UVM_NONE);
                   `uvm_info(get_type_name(),$sformatf("----------spi_vif.data_array data_array=%0p",spi_vif.data_array),UVM_NONE);
                  for(int j=0;j<l;j++) begin
                    if(spi_vif.data_array[j] ==queue[j]) begin
                    `uvm_info(get_type_name(),$sformatf("--------------------spi_input=%0p and wishbone output=%0p MATCHING:::at count=%0p",spi_vif.data_array[j],queue[j],j),UVM_NONE);
            			end
            			else begin
              				 `uvm_info(get_type_name(),$sformatf("--------------------spi_input=%0p and wishbone output=%0p  NOT MATCHING:::at count =%p",spi_vif.data_array[j],queue[j],j),UVM_NONE);
                        end
            			end
                    
          		end
              end
              if(wb_vif.wb_we_i==1) begin
                @(posedge spi_vif.sclk_pad_o) begin
                  output_spi_data.push_front(spi_vif.mosi_pad_o);
                 // `uvm_info(get_type_name(),$sformatf("----------output spi data_array=%0p",output_spi_data),UVM_NONE);
                
                len=output_spi_data.size();
               //   x=w_pkt.wb_dat_i;
                  x = { >> {w_pkt.wb_dat_i}};
              //  `uvm_info(get_type_name(),$sformatf("----------output spi data_array=%0p,and len=%0p and x=%0p ",output_spi_data,len,x),UVM_NONE);
                  if(len==32) begin
                  for(int i=0;i<len;i++) begin
                    if(x[i]==output_spi_data[i])begin
                  //  `uvm_info(get_type_name(),$sformatf("--------------------wishbone_input and spi output MATCHING::: mosi_pad_o=%0p,wb_dat_i =%0pand count=%0d,data_array=%0p",output_spi_data[i],x[i],len,output_spi_data),UVM_NONE);
            			end
            			else begin
              		//		 `uvm_info(get_type_name(),$sformatf("--------------------wishbone_input and spi output NOT MATCHING::: mosi_pad_o=%0p,wb_dat_i =%0pand count=%0d,data_array=%0p",output_spi_data[i],x[i],len,output_spi_data),UVM_NONE);
            			end
                end
                    output_spi_data.delete();
                  end
                end

              end
                  
        	end 
        end
      	
   // join
  endtask
endclass