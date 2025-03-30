
`timescale 1ns/1ns

module tb_breath_led;

reg                      sclk               ;
reg                      s_rst_n            ;
wire [3:0]                led               ;

initial begin
    sclk =              1                   ;
    s_rst_n <=          0                   ;
    #100
    s_rst_n <=          1                   ;


end

always #5 sclk = ~sclk;

//paramter定义的都可以如下的方式修改参数值，方便调试测试

breath_led #(
    .DELAY_2US(50),
    .DELAY_2MS(50),
    .DELAY_2S(50)
) breath_led_inst(
    .sclk                   (sclk   )             ,
    .s_rst_n                (s_rst_n)             ,
    .led                    (led    )                   
);

endmodule
