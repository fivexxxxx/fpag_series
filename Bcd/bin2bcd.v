//二进制转BCD码
// bin_data: 8位二进制数据;
//bin_vld: 1位有效信号;
//shift_work:转换工作信号;
//shift_reg: 15bits移位寄存器;
//shift_cnt:左移计数器; 计数值为偶数时，做满5，加3的判断；为奇数时，左移；
//bcd_data: 有两种赋值方式，组合逻辑和时序逻辑，推荐使用时序逻辑；
//bcd_vld: 1位有效信号;
//生成代码时，注意格式，保持一致性；
module bin2bcd #(
        parameter BIN_WIDTH     =       7, //二进制数据宽度
        parameter BCD_WIDTH     =       8  //BCD数据宽度;
)(
        input                                   sclk                , //时钟信号,
        input                                   s_rst_n             , //复位信号,低有效
        input                                   bin_vld             , //二进制数据有效信号,
        input       [BIN_WIDTH-1:0]             bin_data            , //二进制数据
        output reg                              bcd_vld             ,  //BCD数据有效信号,
        output reg  [BCD_WIDTH-1:0]             bcd_data            //BCD数据
);  
//定义信号
reg         [BCD_WIDTH + BIN_WIDTH -1:0]        shift_reg           ; //移位寄存器
reg         [7:0]                               shift_cnt           ; //左移计数器  
reg                                             shift_work          ; //转换工作信号

//shift_work信号赋值
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 1'b0) begin
        shift_work  <= 1'b0;
    end else if(bin_vld == 1'b1) begin
        shift_work  <= 1'b1;
    end else if(shift_cnt==({BIN_WIDTH,1'b0}-1))    begin
        shift_work  <=1'b0;
    end
end
//移位寄存器赋值
integer i;
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 1'b0) begin
        shift_reg <= 0;
    end else if(bin_vld == 1'b1 && shift_work==1'b0) begin//可以不加shift_work==1'b0的判断
        shift_reg <= {{BCD_WIDTH{1'b0}},bin_data};//{6{1'b0}}=6'b00_0000;
    end else if(shift_work == 1'b1) begin
        if(shift_cnt[0] == 1'b0) begin//偶数时，做满5，加3的判断
            for(i=0;i<(BCD_WIDTH>>2);i=i+1)begin
                shift_reg[BIN_WIDTH+4*i+:4]<=(shift_reg[BIN_WIDTH+4*i+:4] >='d5)?
                            shift_reg[BIN_WIDTH+4*i+:4] + 'd3 : 
                            shift_reg[BIN_WIDTH+4*i+:4];
            end
        end
        else begin
            shift_reg <= {shift_reg[BCD_WIDTH + BIN_WIDTH -2:0],1'b0}; //左移一位

        end   
        end
        //不加shift_work==1'b0的判断，将判断移动到这里
    end
//shift_cnt赋值
    always @(posedge sclk or negedge s_rst_n) begin
        if(s_rst_n == 1'b0) begin
            shift_cnt <= 0;
        end else if(shift_work == 1'b1) begin
            shift_cnt <= shift_cnt + 1'b1;
        end else
            shift_cnt <= 0;
        end
//bcd_vld赋值
    always @(posedge sclk or negedge s_rst_n) begin
        if(s_rst_n == 1'b0) begin
            bcd_vld <= 1'b0;
        end else if(shift_cnt == (BIN_WIDTH<<1)) begin
            bcd_vld <= 1'b1;
        end else 
            bcd_vld <= 1'b0;
        end 

//bcd_data赋值
    always @(posedge sclk or negedge s_rst_n) begin
        if(s_rst_n == 1'b0) begin
            bcd_data <= 0;
        end else if(shift_cnt == (BIN_WIDTH<<1)) begin
            bcd_data <= shift_reg [BCD_WIDTH + BIN_WIDTH-1:BIN_WIDTH];
        end
    end
    
endmodule