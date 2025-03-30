`timescale 1ns/1ns

module tb_shift_led;

reg                      sclk               ;
reg                      s_rst_n            ;
wire [3:0]               led                ;

initial begin
    sclk =              1                   ;
    s_rst_n <=          0                   ;
    #10
    s_rst_n <=          1                   ;


end

always #5 sclk = ~sclk;
//修改参数值，模拟1秒的延时，此处为49个时钟周期，实际为49_999_999周期

//defparam shift_led_inst.DELAY_1S = 'd49;

shift_led #(
    .DELAY_1S              (49             )//此处为49_999_999周期
) shift_led_inst(
    .sclk                   (sclk           )  ,
    .s_rst_n                (s_rst_n        )  ,
    .led                    (led            )                   
);

endmodule
