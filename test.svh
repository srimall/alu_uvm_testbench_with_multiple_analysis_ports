class test extends base_test;
    `uvm_component_utils(test);
    
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction : new
    
    task run_phase(uvm_phase phase);
        test_seq test_seq;
        test_seq = new("test_seq");
        
        phase.raise_objection(this);
            test_seq.start(sequencer_h);
        phase.drop_objection(this);
    
    endtask : run_phase

endclass : test