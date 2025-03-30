
module key_debounce(
    input                   sclk                    ,
    input                   s_rst_n                 ,
    input                   key                     ,
    output reg              key_flag         
);
parameter DELAY_10MS    =   'd50_000_0              ; //10ms


reg [18:0]                  cnt_10ms                ;

//
always@(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n==1'b0) begin
        cnt_10ms <= 19'd0;
    end
    else if(key ==1'b1) begin
        cnt_10ms <= 19'd0;
        end
    else if(cnt_10ms < DELAY_10MS) begin
        cnt_10ms <= cnt_10ms + 1'b1;
    end
end
// key_flag 逻辑判断
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 1'b0) begin
        key_flag <= 1'b0;
    end
    else if(cnt_10ms == DELAY_10MS-1) begin
        key_flag <= 1'b1;
    end
    else begin
        key_flag <= 1'b0;
    end
end



endmodule