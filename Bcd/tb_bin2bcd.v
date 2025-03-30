`timescale 1ns / 1ps
//仿真文件
module tb_bin2bcd;

reg                                 sclk            ;
reg                                 s_rst_n         ;
reg                                 bin_vld         ;
reg         [6:0]                   bin_data        ;
wire                                bcd_vld         ;
wire        [7:0]                   bcd_data        ;


initial begin
    sclk = 1;
    s_rst_n <=0;
    bin_vld <= 0;
    bin_data <= 0;
    #100;
    s_rst_n <=1;
    #100;
    s_rst_n <=0;
    #100;
    bin_vld <= 1;
    bin_data <= 30;
    #10;
    bin_vld <= 0;
    
end
always #5 sclk = ~sclk; //时钟周期10ns

bin2bcd #(
    .BIN_WIDTH(7),
    .BCD_WIDTH(8)
) u_bin2bcd (
    .sclk       (sclk       ),
    .s_rst_n    (s_rst_n    ),
    .bin_vld    (bin_vld    ),
    .bin_data   (bin_data   ),
    .bcd_vld    (bcd_vld    ),
    .bcd_data   (bcd_data   )
);
endmodule
