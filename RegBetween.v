module RegBetween
    #(parameter SIZE=32)
    (
        input clk,
        input rst,
        input [SIZE-1:0] dataIn,
        output reg [SIZE-1:0] dataOut,
        input [1:0] flush
    );

    always @(posedge clk or posedge rst)
        if (rst)
            dataOut <= 0;
        else if (flush == 2'b00) // no flush
            dataOut <= dataIn;
        else if (flush == 2'b01) // flush
            dataOut <= 0;
        else if (flush == 2'b10) // keep
            dataOut <= dataOut;
        else
            dataOut <= 0;

endmodule
