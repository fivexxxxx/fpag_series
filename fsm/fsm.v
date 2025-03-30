
//fsm
module fsm( 
    input                   sclk                       , 
    input                   s_rst_n                    ,
        
    input                   pi_a                       ,
    output reg              po_k1                      ,
    output reg              po_k2                      
);
//定义状态
parameter                   S_IDLE    =     2'd0       ;
parameter                   S_START   =     2'd1       ;
parameter                   S_STOP    =     2'd2       ;
parameter                   S_CLEAR   =     2'd3       ;

reg [1:0]                   state                      ;

//状态机写法：一段式；二段式；三段式； 
//下面是二段式写法：

always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 0) begin  
        state <= S_IDLE;
    end else begin
        case(state)
            S_IDLE:   if(pi_a == 1'b1) 
                            state <= S_START;
                      else  
                            state <= S_IDLE ;
            S_START:  if(pi_a == 1'b0)
                            state <= S_STOP;
                      else            
                            state <= S_START;
            S_STOP:   if(pi_a == 1'b1) 
                            state <= S_CLEAR;
                      else
                            state <= S_STOP;
            S_CLEAR:  if(pi_a == 1'b0)
                            state <= S_IDLE;
                      else
                            state <= S_CLEAR;
            default:    state <= S_IDLE;
        endcase   
    end
end

always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 0) begin
        po_k1 <= 1'b0;
    end
    else if(state == S_CLEAR && pi_a==1'b0) begin
        po_k1 <= 1'b1;
    end else begin
        po_k1 <= 1'b0;
        end
end

always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 0) begin
        po_k2 <= 1'b0;
    end
    else if(state == S_STOP && pi_a==1'b1) begin
        po_k2 <= 1'b1;
    end else begin
        po_k2 <= 1'b0;
        end
end

endmodule