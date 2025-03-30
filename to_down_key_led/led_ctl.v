module led_ctl(
    input                   sclk                    ,
    input                   s_rst_n                 ,    
    input                   key_flag                ,
    output   reg            led                     

);

always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 1'b0) begin
        led <= 1'b0;
    end
    else if(key_flag == 1'b1) begin
        led <= ~led;
    end
end

endmodule