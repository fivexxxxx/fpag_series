module top(
    input                   sclk                    ,
    input                   s_rst_n                 ,
    input                   key                     ,
    output wire             led                  

);
wire  key_flag;


key_debounce u0_key_debounce_inst(
    .sclk       (sclk                     )          ,
    .s_rst_n    (s_rst_n                  )          ,
    .key        (key                      )          ,
    .key_flag   (key_flag                 )     
);

led_ctl u1_led_ctl_inst(
    .sclk       (sclk                     )           ,
    .s_rst_n    (s_rst_n                  )           ,    
    .key_flag   (key_flag                 )           ,
    .led        (led                      )           

);

endmodule