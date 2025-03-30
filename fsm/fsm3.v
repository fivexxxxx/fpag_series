
//fsm
module fsm( 
    input                   sclk                       , 
    input                   s_rst_n                    ,
        
    input                   pi_a                       ,
    output reg              po_k1                      ,
    output reg              po_k2                      
);
//定义状态
parameter                   S_IDLE    =     4'b0001    ;
parameter                   S_START   =     4'b0010    ;
parameter                   S_STOP    =     4'b0100    ;
parameter                   S_CLEAR   =     4'b1000    ;

reg [3:0]                   cuttent_state              ;
reg [3:0]                   next_state                 ;

//状态机写法：一段式；二段式；三段式； 
//下面是三段式写法：
always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 1'b0) begin  
        cuttent_state <= S_IDLE;
    end else begin
        cuttent_state <= next_state;
    end
end

always @(*) begin
    case(cuttent_state)
        S_IDLE:   begin
            if(pi_a == 1'b1) begin
                next_state = S_START;
            end else begin
                next_state = S_IDLE ;
            end
        end
        S_START:  begin
            if(pi_a == 1'b0) begin
                next_state = S_STOP;
            end else begin
                next_state = S_START;
            end
        end
        S_STOP:   begin
            if(pi_a == 1'b1) begin
                next_state = S_CLEAR;
            end
            else begin
                next_state = S_STOP;
            end
        end
        S_CLEAR:  begin
            if(pi_a == 1'b0) begin
                next_state = S_IDLE;
            end else begin
                next_state = S_CLEAR;
            end
        end
        default : next_state = S_IDLE;
    endcase
end


always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 0) begin
        po_k1 <= 1'b0;
    end
    else if(cuttent_state == S_CLEAR && pi_a==1'b0) begin
        po_k1 <= 1'b1;
    end else begin
        po_k1 <= 1'b0;
        end
end

always @(posedge sclk or negedge s_rst_n) begin
    if(s_rst_n == 0) begin
        po_k2 <= 1'b0;
    end
    else if(cuttent_state == S_STOP && pi_a==1'b1) begin
        po_k2 <= 1'b1;
    end else begin
        po_k2 <= 1'b0;
        end
end

endmodule