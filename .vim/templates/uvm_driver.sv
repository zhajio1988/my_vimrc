`ifndef __{:UPPERNAME:}_DRIVER_SV__
 `define __{:UPPERNAME:}_DRIVER_SV__

class {:NAME:}_driver extends uvm_driver #({:TRANSACTION:});
   
   // Attributes
   virtual {:NAME:}_if vif;
   {:TRANSACTION:} req;

   `uvm_component_utils_begin({:NAME:}_driver)
   `uvm_component_utils_end

   // Constructor
   function new(string name="{:NAME:}_driver", uvm_component parent=null);
      super.new(name, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual {:NAME:}_if)::get(this, "", "{:NAME:}_vif", vif)) begin
        `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
      end
   endfunction

   task reset_phase(uvm_phase phase);
      super.reset_phase(phase);
      phase.raise_objection(this);
      //TODO Vif signals reset here
      phase.drop_objection(this);
   endtask   
   
   task main_phase(uvm_phase phase);
      super.main_phase(phase);
      forever begin
         // Get the next data item from sequencer
         seq_item_port.get_next_item(req);
         phase.raise_objection(this);
         // Execute the item
         drive_item(req);
 `ifdef USING_RESPONSE
         {:CONSTRUCT_RSP_ITEM:} rsp;
         rsp.set_id_info(req);
         // response
         // seq_item_port.item_done(rsp);
         seq_item_port.put_response(rsp);
 `else
         // consume the request
         seq_item_port.item_done();
 `endif
         phase.drop_objection(this);
      end
   endtask
   
   task drive_item({:TRANSACTION:} item);
      //TODO User need to add drive logic 
   endtask 

endclass

`endif
