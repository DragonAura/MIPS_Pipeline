module LED(
        input clk,
        input rst,
        input memWrite,
        input [31:0] dataIn,
        input [31:0] address,
        output reg [11:0] digi
    );

    always @(posedge clk or posedge rst) begin
        if (rst)
            digi <= 0;
        else if (address == 32'h40000010 && memWrite)
            digi <= dataIn[11:0];
        else
            digi <= digi;
    end
endmodule
