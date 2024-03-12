`ifndef __{:UPPERNAME:}_AGENT_SV__
 `define __{:UPPERNAME:}_AGENT_SV__

class {:NAME:}_agent extends uvm_agent;
   `uvm_component_utils({:NAME:}_agent)

   uvm_analysis_port #({:TRANSACTION:}) analysis_port;
   {:NAME:}_sequencer #({:TRANSACTION:}) sqr;
   {:NAME:}_monitor                      mon;
   {:NAME:}_driver                       drv;
   virtual {:NAME:}_if vif;

   function new (string name = "{:NAME:}_agent", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   // Construct sub-components
   // retrieve and set sub-component
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual {:NAME:}_if)::get(this, "", "{:NAME:}_vif", vif)) begin
         `uvm_fatal("AGT/NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
      end      
      // Monitor is always present
      mon = {:NAME:}_monitor::type_id::create("mon", this);
      uvm_config_db#(virtual {:NAME:}_if)::set(this, "mon", "{:NAME:}_vif", vif);
      // Only build the driver and sequencer if active
      if(this.get_is_active() == UVM_ACTIVE) begin
         sqr = {:NAME:}_sequencer#({:TRANSACTION:})::type_id::create("sqr", this);
         drv = {:NAME:}_driver::type_id::create("drv", this);
         uvm_config_db#(virtual {:NAME:}_if)::set(this, "drv", "{:NAME:}_vif", vif);
      end
   endfunction

   // Connect sub-components
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      analysis_port = mon.analysis_port;
      // Only connect the driver and the sequencer if active
      if(this.get_is_active() == UVM_ACTIVE) begin
         drv.seq_item_port.connect(sqr.seq_item_export);
      end
   endfunction

endclass
`endif
