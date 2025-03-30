module flash_led(
    input                   sclk                    ,
    input                   s_rst_n                 ,
    output reg  [3:0]       led                  

);
//localparam DELAY_1S = 'd49_999_999 ;//加速仿真，可以修改计数器上限'd49，以加快仿真速度 原来： 'd49_999_999
localparam DELAY_1S = 'd49;
//50Mhz时钟，计数1s
// t= 100/5=20ns
reg [25:0]                  cnt                     ;

//计数器功能描述
always@(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0) begin
        cnt <= 'd0;
    end
    else if(cnt ==DELAY_1S) begin
        cnt <= 'd0;
    end
    else begin
        cnt <= cnt + 1'b1;
    end 
end
// 控制LED闪烁
always@(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0) begin
        led <= 4'b0000;
    end
    else if(cnt == DELAY_1S) begin
        led <= ~led;
    end
end  
endmodule