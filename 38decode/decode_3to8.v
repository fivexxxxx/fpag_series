
module  decode_3to8(
    input       [2:0]                  pi_data         ,
    output  reg [7:0]                  po_data         

);


always @(*) begin
    case (pi_data)
        0: po_data=8'b0000_0001;
        1: po_data=8'b0000_0010;
        2: po_data=8'b0000_0100;
        3: po_data=8'b0000_1000;
        4: po_data=8'b0001_0000;
        5: po_data=8'b0010_0000;
        6: po_data=8'b0100_0000;
        7: po_data=8'b1000_0000;
        default: po_data=8'b0000_0000;
    endcase
end 

endmodule
