
/*
module switch_2to1 (
    input                       sel                 ,
    input                       data_a              ,
    input                       data_b              ,
    output  wire                data_c               
);

assign   data_c =(sel==0)? data_a :data_b;
    
endmodule
*/

/*
module switch_2to1 (
    input                       sel_a               ,
    input                       sel_b               ,
    input                       data_a              ,
    input                       data_b              ,
    output  wire                data_c               // always --reg; assign -- wire
);

//assign   data_c =(sel_a==0)?((sel_b==0)? data_a:0) :((sel_b==1)?data_b:0);

endmodule
*/


module switch_2to1 (
    input                       sel_a               ,
    input                       sel_b               ,
    input                       data_a              ,
    input                       data_b              ,
    output  reg                 data_c               // always --reg; assign -- wire
);

// always --对 reg型赋值
always @(*) begin
    if(sel_a==0) begin 
        if(sel_b==0)
            data_c = data_a;
        /*else
            data_c  = 0;*/
    end
    else 
        if(sel_b==1)
                data_c  =   data_b;
            else
                data_c  =   0;
end

endmodule