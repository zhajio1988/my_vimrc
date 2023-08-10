`ifndef __{:UPPERNAME:}_BASE_SEQ_SV__
 `define __{:UPPERNAME:}_BASE_SEQ_SV__

class {:NAME:}_base_seq extends uvm_sequence#({:TRANSACTION:});
   `uvm_object_utils({:NAME:}_base_seq)

   `uvm_declare_p_sequencer({:NAME:}_vir_seqr)

   function new(string name = "{:NAME:}_base_seq");
      super.new(name);
   endfunction

   virtual task pre_start();
      if(starting_phase != null) begin
         starting_phase.raise_objection(this);
      end
   endtask

   virtual task body();
   endtask

   virtual task post_start();
      if(starting_phase != null) begin
         starting_phase.drop_objection(this);
      end
   endtask

endclass

`endif
