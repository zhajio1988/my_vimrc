`ifndef __{:UPPERNAME:}_VIR_SEQR_SV__
 `define __{:UPPERNAME:}_VIR_SEQR_SV__

class {:NAME:}_vir_seqr extends uvm_sequencer#(uvm_sequence_item);
   `uvm_component_utils({:NAME:}_vir_seqr)

   uvm_sequencer_base sequencers[string];

   function new(string name = "{:NAME:}_vir_seqr", uvm_component parent);
      super.new(name, parent);
   endfunction

   function void register_seqr(string name, uvm_sequencer_base sequencer);
      this.sequencers[name] = sequencer;
   endfunction

   function uvm_sequencer_base get_seqr(string name);
      if(this.sequencers.exists(name)) begin
         return this.sequencers[name];
      end
      `uvm_fatal(this.get_full_name(), $psprintf("%s seqr has not been registered!", name))
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //TODO add some logic here
   endfunction

endclass

`endif
