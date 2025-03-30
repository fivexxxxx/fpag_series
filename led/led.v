
//变量定义，要求：关键字缩进1tab,变量名缩进4tab
//LED灯控制模块，4个ledd灯，
module led (
    output    wire             led1, //led0灯
    output    wire             led2, //led1灯
    output    wire             led3, //led2灯
    output    wire             led4 //led3灯
);

assign led1     =              1'b1; //led0灯常亮
assign led2     =              1'b1; //led1灯常灭
assign led3     =              1'b1; //led2灯常亮
assign led4     =              1'b1; //led3灯常灭
    
endmodule