// 静态显示 12 34
module seg_drive(
    input                   sclk            ,
    input                   s_rst_n         ,
    output reg [3:0]        sel             ,
    output reg [7:0]        seg 
    );

localparam                  DELAY_1MS   = 'd50_000  ;
reg [15:0]                  cnt                     ;
//定义数码管显示数据
localparam   SEG_NUM0 = 8'b1100_0000; // 0
localparam   SEG_NUM1 = 8'b1111_1001; // 1
localparam   SEG_NUM2 = 8'b1010_0100; // 2  
localparam   SEG_NUM3 = 8'b1011_0000; // 3  
localparam   SEG_NUM4 = 8'b1001_1000; // 4
localparam   SEG_NUM5 = 8'b1001_0010; // 5
localparam   SEG_NUM6 = 8'b1000_0010; // 6
localparam   SEG_NUM7 = 8'b1111_1000; // 7
localparam   SEG_NUM8 = 8'b1000_0000; // 8
localparam   SEG_NUM9 = 8'b1001_0000; // 9


// 1ms延时计数器
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0)
        cnt <= 'd0;
    else if(cnt == DELAY_1MS - 1)
        cnt <= 'd0;
    else 
        cnt <= cnt + 1'b1;
end
//sel信号控制
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0)
        sel <= 4'b1110;
    else if(cnt == DELAY_1MS - 1)
        sel <= {sel[2:0], sel[3 ]};//移位
end
//组合逻辑，CASE语句 1和2是一组，3和4是一组，以此类推
always @(*) begin
    case(sel)
        4'b1110: seg = SEG_NUM1;
        4'b1101: seg = SEG_NUM2;
        4'b1011: seg = SEG_NUM3;
        4'b0111: seg = SEG_NUM4;
        default : seg = SEG_NUM0;
    endcase
end

    
endmodule