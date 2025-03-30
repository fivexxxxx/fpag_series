
//逻辑门

module logic_gate(
    input                   port_a                  ,
    input                   port_b                  ,
    input                   port_c                  ,
    output  wire            rslt_e                  ,
    output  wire            rslt_f                  ,
    output  wire            rslt_g                  ,
    output  wire            rslt_h      
    
);

assign      rslt_e  =       port_a & port_b     ;
assign      rslt_f  =       ~port_b             ;
//或门
assign      rslt_g  =       port_a | port_c     ;
assign      rslt_h  =       port_b ^ port_c     ;
//


endmodule

