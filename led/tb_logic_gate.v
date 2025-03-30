`timescale 1ns / 1ps
   
module tb_logic_gate();

//信号源，输入的信号
reg test_port_a;
reg test_port_b;
reg test_port_c;

//
wire        test_rslt_e;
wire        test_rslt_f;
wire        test_rslt_g;
wire        test_rslt_h;




// initial 从0时刻开始，且执行一次
initial begin
    test_port_a=0;
    #10;
    test_port_a=1;
    #20
    test_port_a=0;
end

initial begin
    test_port_b=0;
    #20;
    test_port_b=1;
    #20
    test_port_b=0;
end
initial begin
    test_port_c=0;
    #10;
    test_port_c=1;
    #10
    test_port_c=0;
    #10
    test_port_c=1;
end



logic_gate logic_gate_inst(
    .port_a (test_port_a      )    ,
    .port_b (test_port_b      )    ,
    .port_c (test_port_c      )    ,
    .rslt_e (test_rslt_e      )    ,
    .rslt_f (test_rslt_f      )    ,
    .rslt_g (test_rslt_g      )    ,
    .rslt_h (test_rslt_h      )
    
);

endmodule 