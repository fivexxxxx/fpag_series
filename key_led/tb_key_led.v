`timescale 1ns/1ns

module tb_key_led;
//时钟和复位信号
reg                     sclk                ; //时钟信号
reg                     s_rst_n             ; //复位信号
reg                     key                 ; //按键信号
wire                    led                 ; //LED信号

reg [31:0]              cnt                 ; //计数器

initial begin
    sclk                =              1;
    s_rst_n             =              0;
    #100;
    s_rst_n = 1;
end

always #5 sclk = ~sclk;

//计数器计数
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 0) begin
        cnt <= 'd0;
    end 
    if(cnt[31] == 0) begin
        cnt <= cnt + 1'b1;
    end
end

//模拟按键信号
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 0) begin
        key <= 1'b1;
    end else if (cnt <= 'd100) begin    //按键还没按下
        key <=1'b1;
    end
    else if(cnt>'d100 && cnt <= 'd200) begin    //按键按下,前抖动
        key <={$random%2} ;
    end
    else if(cnt>'d200 && cnt <= 'd500) begin    //按键按下,处于稳定状态

        key <=1'b0;
    end
    else if(cnt>'d500 && cnt <= 'd600) begin    //按键按下,后抖动
        key <={$random%2} ;
    end
    else begin    //按键释放
        key <=1'b1;
    end
end

//仿真参数设置
defparam  key_led_inst.DELAY_10MS = 110; //仿真时大于100个时钟周期即可认为是10ms



key_led key_led_inst(
    .sclk    (  sclk                ),
    .s_rst_n (  s_rst_n             ),
    .key     (  key                 ),
    .led     (  led                 )
);
endmodule