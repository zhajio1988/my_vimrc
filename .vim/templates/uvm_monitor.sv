`ifndef __{:UPPERNAME:}_MONITOR_SV__
 `define __{:UPPERNAME:}_MONITOR_SV__

class {:NAME:}_monitor extends uvm_monitor;
   `uvm_component_utils({:NAME:}_monitor)

   // Attributes
   virtual {:NAME:}_if vif;
   uvm_analysis_port #({:TRANSACTION:}) analysis_port;
   protected {:TRANSACTION:} mon_trans;

   function new(string name="{:NAME:}_monitor", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   function build_phase(uvm_phase phase);
      super.build_phase(phase);
      analysis_port = new("analysis_port", this);
      if(!uvm_config_db#(virtual {:NAME:}_if)::get(this, "", "{:NAME:}_vif", vif)) begin
         `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
      end
   endfunction

   task main_phase(uvm_phase phase);
      super.main_phase(phase);
      forever begin
         mon_trans = {:TRANSACTION:}::type_id::create("mon_trans", this); 
         collect_transactions(mon_trans);
         analysis_port.write(mon_trans);
      end       
   endtask

   task collect_transactions({:TRANSACTION:} mon_tr);
      //TODO User need to add monitoring logic
   endtask

endclass

`endif
