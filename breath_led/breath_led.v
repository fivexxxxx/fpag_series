//呼吸灯
module breath_led
(
    input                       sclk                     ,  //系统时钟
    input                       s_rst_n                  ,  //系统复位信号，低电平有效
    output  reg [3:0]           led                        //led灯控制信号
);
//参数定义
parameter                       DELAY_2US =     'd100    ;  //2us计数器最大值
parameter                       DELAY_2MS =     'd1000   ;  //2ms计数器最大值
parameter                       DELAY_2S  =     'd1000   ;  //2s计数器最大值



reg [6:0]                       cnt_2us                  ;  //2us计数器
reg [9:0]                       cnt_2ms                  ;  //2ms计数器
reg [9:0]                       cnt_2s                   ;  //2s计数器
reg                             cnt_4s                   ;  //4s计数器

//2us计数器
always @(posedge sclk or negedge s_rst_n)
begin
    if(s_rst_n == 1'b0) begin
            cnt_2us <= 0;
        end
    else if(cnt_2us == DELAY_2US - 1)begin
        cnt_2us <= 0;
    end
    else begin
        cnt_2us <= cnt_2us + 1'b1;
    end
 end
//2ms计数器
 always @(posedge sclk or negedge s_rst_n)
 begin
    if(s_rst_n == 1'b0)begin
        cnt_2ms <= 0;
    end
    else if(cnt_2us == DELAY_2US - 1 && cnt_2ms == DELAY_2MS - 1)begin
        cnt_2ms <= 0;
    end
    else if(cnt_2us == DELAY_2US - 1)begin
        cnt_2ms <= cnt_2ms + 1'b1;
    end
 end
//2s计数器
 always @(posedge sclk or negedge s_rst_n)
 begin
    if(s_rst_n == 1'b0)begin
        cnt_2s <= 0;
    end
    else if(cnt_2us == DELAY_2US - 1 && cnt_2ms == DELAY_2MS - 1 && cnt_2s == DELAY_2S - 1)begin
        cnt_2s <= 0;
    end
    else if(cnt_2ms == DELAY_2MS - 1 && cnt_2us == DELAY_2US - 1)begin
        cnt_2s <= cnt_2s + 1'b1;
    end
 end
//4s计数器 2s翻转一次
always @(posedge sclk or negedge s_rst_n) 
begin 
    if(s_rst_n == 1'b0)begin
        cnt_4s <= 1'b0;
    end
    else if(cnt_2us == DELAY_2US - 1 && cnt_2ms == DELAY_2MS - 1 && cnt_2s == DELAY_2S - 1)begin
        cnt_4s <= ~cnt_4s;
    end
end
//led控制信号 默认都熄灭，在前2秒逐渐变亮，后2秒逐渐变暗
always @(posedge sclk or negedge s_rst_n)
begin
    if(s_rst_n == 1'b0) begin
        led <= 4'b0000;
        end
    else if(cnt_4s ==1'b0 && cnt_2ms<=cnt_2s)begin
        led <=4'b1111;
        end
    else if(cnt_4s ==1'b1 && cnt_2ms>=cnt_2s)begin
        led <= 4'b1111;
        end
    else begin
        led <= 4'b0000;
        end
 end








endmodule   