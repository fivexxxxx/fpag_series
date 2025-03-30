// 动态显示 
module seg_drive(
    input                   sclk                            ,
    input                   s_rst_n                         ,
    output reg [3:0]        sel                             ,
    output reg [7:0]        seg 
    );

localparam                  DELAY_1MS   = 'd50_000          ;//基于1ms时钟周期的1ms延时数
localparam                  DELAY_1S    = 'd1000            ;//基于1ms时钟周期的1s延时数

//计数器定义
reg [15:0]                  cnt_1ms                         ;
reg [9:0]                   cnt_1s                          ;
//定义数码管显示数据
localparam                  SEG_NUM0    =   8'b1100_0000    ; // 0
localparam                  SEG_NUM1    =   8'b1111_1001    ; // 1
localparam                  SEG_NUM2    =   8'b1010_0100    ; // 2  
localparam                  SEG_NUM3    =   8'b1011_0000    ; // 3  
localparam                  SEG_NUM4    =   8'b1001_1000    ; // 4
localparam                  SEG_NUM5    =   8'b1001_0010    ; // 5
localparam                  SEG_NUM6    =   8'b1000_0010    ; // 6
localparam                  SEG_NUM7    =   8'b1111_1000    ; // 7
localparam                  SEG_NUM8    =   8'b1000_0000    ; // 8
localparam                  SEG_NUM9    =   8'b1001_0000    ; // 9
localparam                  SEG_NONE    =   8'b1111_1111    ; // 无显示

wire [3:0]                  num0                            ;
wire [3:0]                  num1                            ;
wire [3:0]                  num2                            ;
wire [3:0]                  num3                            ;
reg  [3:0]                  cnt_num                         ;
reg  [3:0]                  disp_num                        ;
// 1ms延时计数器
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0)
    cnt_1ms <= 'd0;
    else if(cnt_1ms == DELAY_1MS - 1)
        cnt_1ms <= 'd0;
    else 
        cnt_1ms <= cnt_1ms + 1'b1;
end
//1s延时计数器
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0)
        cnt_1s <= 'd0;
    else if(cnt_1ms == DELAY_1MS - 1 && cnt_1s == DELAY_1S - 1)
        cnt_1s <= 'd0;
    else if(cnt_1ms == DELAY_1MS - 1)
        cnt_1s <= cnt_1s + 1'b1;
end
//cnt_num 控制,1秒到了就更新cnt_num的值
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0)
        cnt_num <= 'd0;
    else if(cnt_1ms == DELAY_1MS - 1 && cnt_1s == DELAY_1S - 1 && cnt_num == 'd9)
        cnt_num <= 'd0;
    else if(cnt_1ms == DELAY_1MS - 1 && cnt_1s == DELAY_1S - 1)
        cnt_num <= cnt_num + 1'b1;
end


//sel信号控制
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0)
        sel <= 4'b1110;
    else if(cnt_1ms == DELAY_1MS - 1)
        sel <= {sel[2:0], sel[3 ]};//移位
end

assign num0 = 'd1;
assign num1 = cnt_num;
assign num2 = 'd0;
assign num3 = cnt_num;

//组合逻辑，CASE语句 ，
always @(*) begin
    case(sel)
        4'b1110     :    disp_num   =    num0   ;
        4'b1101     :    disp_num   =    num1   ;
        4'b1011     :    disp_num   =    num2   ;
        4'b0111     :    disp_num   =    num3   ;
        default     :    disp_num   =    num0   ;
    endcase
end
always @(*) begin
    case(disp_num)
         0          :    seg        =    SEG_NUM0   ;
         1          :    seg        =    SEG_NUM1   ;
         2          :    seg        =    SEG_NUM2   ;
         3          :    seg        =    SEG_NUM3   ;
         4          :    seg        =    SEG_NUM4   ;
         5          :    seg        =    SEG_NUM5   ;
         6          :    seg        =    SEG_NUM6   ;
         7          :    seg        =    SEG_NUM7   ;
         8          :    seg        =    SEG_NUM8   ;
         9          :    seg        =    SEG_NUM9   ;
        default     :    seg        =    SEG_NONE   ;
    endcase
end
    
endmodule