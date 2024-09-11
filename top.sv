module top;
    import uvm_pkg::*;
    import alu_pkg::*;
    
    alu_bfm bfm();
    riscv_alu DUT(.alu_op_i(bfm.alu_op_i),
                  .alu_a_i(bfm.alu_a_i), 
                  .alu_b_i(bfm.alu_b_i), 
                  .alu_p_o(bfm.alu_p_o));
                  
    initial begin
        uvm_config_db #(virtual alu_bfm)::set(null,"*","bfm",bfm);
        run_test("test");
    end

endmodule