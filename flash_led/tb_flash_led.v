`timescale 1ns/1ns

module tb_flash_led;

reg                      sclk               ;
reg                      s_rst_n             ;
wire [3:0]                led               ;

initial begin
    sclk =              1                     ;
    s_rst_n <=          0                     ;
    #100
    s_rst_n <=          1                     ;


end

always #5 sclk = ~sclk;


flash_led flash_led_inst(
    .sclk                   (sclk   )                ,
    .s_rst_n                (s_rst_n)             ,
    .led                    (led    )                   
);



endmodule
