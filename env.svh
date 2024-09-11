class env extends uvm_env;
    `uvm_component_utils(env);
    
    sequencer  sequencer_h;
    driver driver_h;
    monitor monitor_h;
    scoreboard scoreboard_h;
    scoreboard_new scoreboard_new_h;
    scoreboard_multi scoreboard_multi_h;
    
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction 
    
    function void build_phase(uvm_phase phase);
        sequencer_h = new("sequencer_h", this);
        driver_h = driver::type_id::create("driver_h",this);
        monitor_h = monitor::type_id::create("monitor_h",this);
        scoreboard_h = scoreboard::type_id::create("scoreboard_h", this);
        scoreboard_new_h = scoreboard_new::type_id::create("scoreboard_new_h", this);
        scoreboard_multi_h = scoreboard_multi::type_id::create("scoreboard_multi_h", this);
    endfunction : build_phase
    
    function void connect_phase(uvm_phase phase);
        driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        monitor_h.monitor_ap.connect(scoreboard_h.analysis_export);
        monitor_h.monitor_ap.connect(scoreboard_new_h.api);
        monitor_h.monitor_ap.connect(scoreboard_multi_h.api_port_a);
        monitor_h.monitor_ap.connect(scoreboard_multi_h.api_port_b);
        
    endfunction: connect_phase
    
endclass : env