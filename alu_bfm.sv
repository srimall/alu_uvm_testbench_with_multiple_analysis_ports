interface alu_bfm;
    import uvm_pkg::*;
    import alu_pkg::*;

    bit  [  3:0]  alu_op_i;
    bit  [ 31:0]  alu_a_i;
    bit  [ 31:0]  alu_b_i;
    bit  [ 31:0]  alu_p_o;
    
     function string get_alu_op_string(bit [3:0] alu_op);
        
        case(alu_op)
            4'b0000 : return "ALU_NONE";
            4'b0001 : return "ALU_SHIFTL";
            4'b0010 : return "ALU_SHIFTR";
            4'b0011 : return "ALU_SHIFTR_ARITH";
            4'b0100 : return "ALU_ADD";
            // 4'b0101 : return ALU_SUB;
            4'b0110 : return "ALU_SUB";
            4'b0111 : return "ALU_AND";
            4'b1000 : return "ALU_OR";
            4'b1001 : return "ALU_XOR";
            4'b1010 : return "ALU_LESS_THAN";
            4'b1011 : return "ALU_LESS_THAN_SIGNED";
            default: $display("Incorrect ALU Operation");
        endcase
    
    endfunction
    
    task send_data( input bit [3:0] alu_op, bit [31:0] alu_a, bit [31:0] alu_b, output bit [31:0] alu_out);
        alu_op_i =  alu_op;
        alu_a_i = alu_a;
        alu_b_i = alu_b;
        alu_out = alu_p_o;
        
    endtask : send_data
    
    monitor monitor_h;
    
    always @(alu_op_i) begin
    //$display("toggling1");
    
        if(monitor_h != null) begin
            monitor_h.write_to_monitor(alu_op_i,alu_a_i, alu_b_i,alu_p_o);
                //$display("toggling");
            end
    end
    
endinterface: alu_bfm