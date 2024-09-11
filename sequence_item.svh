class sequence_item extends uvm_sequence_item;

    `uvm_object_utils(sequence_item);
    
    function new(string name = "");
        super.new(name);
    endfunction : new
    
    
    // rand variables
    rand bit [3:0] op;
    rand bit [31:0] a;
    rand bit [31:0] b;
    
    bit [31:0] result;
    
    // constraints
    constraint data { a dist {32'h00000000:=1, [32'h00000001:32'hFFFFFFFE]:=1, 32'hFFFFFFFF:=1}; 
                      b dist {32'h00000000:=1, [32'h00000001:32'hFFFFFFFE]:=1, 32'hFFFFFFFF:=1}; }
    
    constraint operation {op dist {[4'b0000:4'b1011]:=1, [4'b1100:4'b1111]:=0};}
    //do_copy
    
    //do_compare
    
    
    //convert2string
    function string convert2string();
        string s ;
        s = $sformatf("%h OP:%s %h = %h ", a, op, b, result);
    endfunction : convert2string

endclass: sequence_item