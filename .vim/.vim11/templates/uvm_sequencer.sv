`ifndef ___{:UPPERNAME:}_SEQR_SV__
`define __{:UPPERNAME:}_SEQR_SV__

class {:NAME:}_seqr extends uvm_sequencer#({:TRANSACTION:});
   `uvm_component_utils({:NAME:}_seqr)

   function new(string name = "{:NAME:}_seqr", uvm_component parent);
      super.new(name, parent);
   endfunction

endclass

`endif
