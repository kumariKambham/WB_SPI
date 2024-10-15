`include "wb_agent.sv"
`include "spi_agent.sv"
`include "scoreboard.sv"
class wb_spi_env extends uvm_env;
  `uvm_component_utils(wb_spi_env)
  
  wb_agent wb_agent_h;
  spi_agent spi_agent_h;
  scoreboard scr_h;
  function new(string name="wb_spi_env", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wb_agent_h=wb_agent::type_id::create("wb_agent_h",this);
    spi_agent_h=spi_agent::type_id::create("spi_agent_h",this);
    scr_h=scoreboard::type_id::create("scr_h",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    wb_agent_h.mon_h.wb_item_collected_port.connect(scr_h.wb_item_collected_export);
    spi_agent_h.mon_h.spi_item_collected_port.connect(scr_h.spi_item_collected_export);
    
  endfunction
endclass