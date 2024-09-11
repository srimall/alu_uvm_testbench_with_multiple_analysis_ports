class scoreboard extends uvm_subscriber #(sequence_item);
    `uvm_component_utils(scoreboard)
    
    
    uvm_tlm_analysis_fifo #(sequence_item) cmd_f;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    function void build_phase(uvm_phase phase);
        cmd_f = new("cmd_f",this);
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
            `uvm_error("SCOREBOARD", "FAIL")
        else
            `uvm_info("SCOREBOARD", "PASS",UVM_MEDIUM);
          
        
    
    
    endfunction : write 
    

endclass : scoreboard