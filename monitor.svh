class monitor extends uvm_component #(sequence_item);
    `uvm_component_utils(monitor);
    
    virtual alu_bfm bfm; 
    uvm_analysis_port #(sequence_item) monitor_ap;
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        //get bfm
        if (! uvm_config_db #(virtual alu_bfm)::get(null,"*", "bfm", bfm))
            `uvm_fatal("Monitor", "Failed to get BFM");
        monitor_ap = new("monitor_ap", this);
    endfunction : build_phase
    
    
   // task run_phase(uvm_phase phase);
   // endtask
    function void connect_phase(uvm_phase connect);
        bfm.monitor_h = this; // pass handle of this class to bfm
    endfunction: connect_phase
   
    function void write_to_monitor(bit  [  3:0]  alu_op_i, bit  [ 31:0]  alu_a_i, bit  [ 31:0]  alu_b_i, bit  [ 31:0]  alu_p_o  );  
        sequence_item cmd;
        `uvm_info ("Monitor", $sformatf("a: %h, b: %h, op: %b, o: %h", alu_a_i, alu_b_i, alu_op_i, alu_p_o), UVM_HIGH);
        
        cmd = new("cmd");
        cmd.op = alu_op_i;
        cmd.a = alu_a_i;
        cmd.b = alu_b_i;
        cmd.result = alu_p_o;
        
        monitor_ap.write(cmd); // broadcast sequence_item to all subscribers
        
    endfunction : write_to_monitor
    
    
endclass : monitor