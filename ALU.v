
module ALU(in1, in2, ALUCtl, Sign, BranchType, out, zero);
    input [31:0] in1, in2;
    input [4:0] ALUCtl;
    input Sign;
    input [2:0] BranchType;
    output reg [31:0] out;
    output reg zero;

    always @(*) begin
        if (BranchType == 3'b000)
            zero <= (in1 > 0);
        else if (BranchType == 3'b001)
            zero <= (in1 <= 0);
        else if (BranchType == 3'b010)
            zero <= (in1 < 0);
        else if (BranchType == 3'b011)
            zero <= (in1 != in2);
        else
            zero <= (out == 0);
    end

    wire ss;
    assign ss = {in1[31], in2[31]};

    wire lt_31;
    assign lt_31 = (in1[30:0] < in2[30:0]);

    wire lt_signed;
    assign lt_signed = (in1[31] ^ in2[31])?
           ((ss == 2'b01)? 0: 1): lt_31;

    // Add your code below (for question 2)
    always @(*)
    case (ALUCtl)
        5'b00000:
            out <= in1 & in2;
        5'b00001:
            out <= in1 | in2;
        5'b00010:
            out <= in1 + in2;
        5'b00110:
            out <= in1 - in2;
        5'b00111:
            out <= {31'h00000000, Sign? lt_signed: (in1 < in2)};
        5'b01100:
            out <= ~(in1 | in2);
        5'b01101:
            out <= in1 ^ in2;
        5'b10000:
            out <= (in2 << in1[4:0]);
        5'b11000:
            out <= (in2 >> in1[4:0]);
        5'b11001:
            out <= ({{32{in2[31]}}, in2} >> in1[4:0]);
        5'b00011:
            out <= in1 * in2;
        5'b00100:
            out <= in1 > 0 ? 1 : 0;
        5'b00101:
            out <= in1 >= 0 ? 1 : 0;
        5'b00011:
            out <= in1 <= 0 ? 1 : 0;
        default:
            out <= 32'h00000000;
    endcase
    // Add your code above (for question 2)

endmodule
