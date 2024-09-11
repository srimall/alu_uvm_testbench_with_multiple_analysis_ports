class test_seq extends uvm_sequence #(sequence_item);

    `uvm_object_utils(test_seq);
    
    
    
    function new(string name = "test");
        super.new(name);
    
    endfunction : new
    
    
    /* 
    
    `define ALU_NONE                                4'b0000
`define ALU_SHIFTL                              4'b0001
`define ALU_SHIFTR                              4'b0010
`define ALU_SHIFTR_ARITH                        4'b0011
`define ALU_ADD                                 4'b0100
`define ALU_SUB                                 4'b0110
`define ALU_AND                                 4'b0111
`define ALU_OR                                  4'b1000
`define ALU_XOR                                 4'b1001
`define ALU_LESS_THAN                           4'b1010
`define ALU_LESS_THAN_SIGNED                    4'b1011



*/    
    function string get_alu_op_string(bit [3:0] alu_op);
        
        case(alu_op)
            4'b0000 : return "ALU_NONE";
            4'b0001 : return "ALU_SHIFTL";
            4'b0010 : return "ALU_SHIFTR";
            4'b0011 : return "ALU_SHIFTR_ARITH";
            4'b0100 : return "ALU_ADD";
            4'b0101 : return "ALU_SUB";
            4'b0110 : return "ALU_SUB";
            4'b0111 : return "ALU_AND";
            4'b1000 : return "ALU_OR";
            4'b1001 : return "ALU_XOR";
            4'b1010 : return "ALU_LESS_THAN";
            4'b1011 : return "ALU_LESS_THAN_SIGNED";
            default: $display("Incorrect ALU Operation");
        endcase
    
    endfunction
 
 
    
    task body();
        repeat(10000) begin : random_loop
             sequence_item packet;
             packet = sequence_item::type_id::create("packet");
             start_item(packet);
             assert(packet.randomize());
             
             finish_item(packet);
             packet.convert2string();// display something
             `uvm_info("TEST",$sformatf("%h OP:%s %h = %h ", packet.a, get_alu_op_string(packet.op), packet.b, packet.result),UVM_MEDIUM);
             #10;
             
        end
        
    
    endtask : body
    


endclass: test_seq