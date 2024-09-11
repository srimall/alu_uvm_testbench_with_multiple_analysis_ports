package alu_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "riscv_defs.v"
    
    

    `include "sequence_item.svh"
    typedef uvm_sequencer #(sequence_item) sequencer;
    
    // Add test class herer
    
    
    // rest of the includes
    `include "driver.svh"
    `include "monitor.svh"
    `include "scoreboard.svh"
    `include "scoreboard_new.svh"
    `include "scoreboard_multi.svh"
    `include "env.svh"
    
    `include "base_test.svh"
    `include "test_seq.svh"
    `include "test.svh"
   
    
endpackage