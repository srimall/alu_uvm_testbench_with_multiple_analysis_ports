class driver extends uvm_driver #(sequence_item);

    `uvm_component_utils(driver);
      
      virtual alu_bfm bfm;
      
      
      function new(string name, uvm_component parent);
        super.new(name,parent);
      endfunction : new
      
      function void build_phase(uvm_phase phase);
        if (!uvm_config_db #(virtual alu_bfm)::get(null, "*","bfm",bfm))
            `uvm_fatal("DRIVER", "Failed to get BFM");
               
      endfunction : build_phase
      
      
      task run_phase(uvm_phase phase);
        sequence_item cmd;
        
        forever begin 
            int result;
            seq_item_port.get_next_item(cmd); // get the data from queue
            bfm.send_data(cmd.op, cmd.a, cmd.b, result);
            cmd.result = result; // send alu out data back
            seq_item_port.item_done();
        end
      
      endtask : run_phase

endclass