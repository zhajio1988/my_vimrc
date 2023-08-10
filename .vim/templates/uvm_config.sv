`ifndef __{:UPPERNAME:}_CONFIG__
 `define __{:UPPERNAME:}_CONFIG__

class {:NAME:}_config extends uvm_object;

   `uvm_object_utils({:NAME:}_config)

   // Virtual Interface
   //

   // active or passive
   uvm_active_passive_enum is_active = UVM_ACTIVE;

   // include the functional coverage or not
   bit has_func_cov = 0;

   // include the scoreboard or not
   bit has_scb = 0;

   //------------------------------------------
   // Constraint
   //------------------------------------------

   //------------------------------------------
   // Methods
   //------------------------------------------

   function new(string name = "{:NAME:}_config");
      super.new(name);
      update_cfg();
   endfunction

   function void update_cfg();
      //TODO plusargs assignment in this function
   endfunction

   function void post_randomize();
      // If has some random variable in this class,
      // maybe you want set it to a fixed value after call this.randomize()
      this.update_cfg();
   endfunction

endclass

`endif

