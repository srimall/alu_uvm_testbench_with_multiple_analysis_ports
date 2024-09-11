class scoreboard_new extends uvm_component;
    `uvm_component_utils(scoreboard_new)
    
    uvm_analysis_imp #(sequence_item,scoreboard_new) api;
    
    // uvm_tlm_analysis_fifo #(sequence_item) cmd_f;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    function void build_phase(uvm_phase phase);
        api = new("api",this);
    endfunction : build_phase
    
    function bit [31:0] predict_result( sequence_item cmd);
        
        bit [31:0] predict;
        
        case(cmd.op) 
            `ALU_ADD : predict = cmd.a + cmd.b;
            `ALU_SUB : predict = cmd.a - cmd.b;
            `ALU_AND : predict = cmd.a & cmd.b;
            `ALU_OR : predict = cmd.a | cmd.b;
            `ALU_XOR : predict = cmd.a ^ cmd.b;
            
        
        endcase 
        return predict;
    
    endfunction : predict_result
    
    
    function void write(sequence_item t);
        //sequence_item cmd;\
        bit [31:0] predict;
        sequence_item cmd;
        $cast(cmd,t.clone());
        
       
        //$display("scoreboard entry");
       
        
        predict = predict_result(cmd);
        //$display("scoreboard predict");
        
        if(predict != cmd.result)
            `uvm_error("SCOREBOARD NEW", "FAIL")
        else
            `uvm_info("SCOREBOARD NEW", "PASS",UVM_MEDIUM);
          
        
    
    
    endfunction : write 
    

endclass : scoreboard_new