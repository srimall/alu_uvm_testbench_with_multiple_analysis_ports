
`uvm_analysis_imp_decl(_port_a)
`uvm_analysis_imp_decl(_port_b)

class scoreboard_multi extends uvm_component;
    `uvm_component_utils(scoreboard_multi)
    
    uvm_analysis_imp_port_a #(sequence_item,scoreboard_multi) api_port_a;
    uvm_analysis_imp_port_b #(sequence_item,scoreboard_multi) api_port_b;
    
    // uvm_tlm_analysis_fifo #(sequence_item) cmd_f;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    function void build_phase(uvm_phase phase);
        api_port_a = new("api_a",this);
        api_port_b = new("api_b",this);
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
    
    
    function void write_port_a (sequence_item t);
        //sequence_item cmd;\
        bit [31:0] predict;
        sequence_item cmd;
        $cast(cmd,t.clone());
        
       
        //$display("scoreboard entry");
       
        
        predict = predict_result(cmd);
        //$display("scoreboard predict");
        
        if(predict != cmd.result)
            `uvm_error("SCOREBOARD PORT A", "FAIL")
        else
            `uvm_info("SCOREBOARD PORT A", "PASS",UVM_MEDIUM);
          
        
    
    
    endfunction : write_port_a 
    
    
    function void write_port_b(sequence_item t);
        //sequence_item cmd;\
        bit [31:0] predict;
        sequence_item cmd;
        $cast(cmd,t.clone());
        
       
        //$display("scoreboard entry");
       
        
        predict = predict_result(cmd);
        //$display("scoreboard predict");
        
        if(predict != cmd.result)
            `uvm_error("SCOREBOARD PORT B", "FAIL")
        else
            `uvm_info("SCOREBOARD PORT B", "PASS",UVM_MEDIUM);
          
        
    
    
    endfunction : write_port_b 
    

endclass : scoreboard_multi