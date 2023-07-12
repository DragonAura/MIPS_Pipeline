
module Control(OpCode, Funct,
                   PCSrc, Branch, RegWrite, RegDst,
                   MemRead, MemWrite, MemtoReg,
                   ALUSrc1, ALUSrc2, ExtOp, LuOp, ALUOp, BranchType);
    input [5:0] OpCode;
    input [5:0] Funct;
    output [1:0] PCSrc;
    output Branch;
    output RegWrite;
    output [1:0] RegDst;
    output MemRead;
    output MemWrite;
    output [1:0] MemtoReg;
    output ALUSrc1;
    output ALUSrc2;
    output ExtOp;
    output LuOp;
    output [3:0] ALUOp;
    output [2:0] BranchType;

    // Add your code below (for question 2)

    // Your code below (for question 1)

    assign PCSrc = (OpCode == 6'h02 || OpCode == 6'h03)?1:(OpCode == 0 && (Funct == 6'h08 || Funct == 6'h09))?2:0;
    assign Branch = (OpCode == 6'h04 || OpCode == 6'h07 || OpCode == 6'h06 || OpCode == 6'h01 || OpCode == 6'h05)?1:0;
    assign RegWrite = (OpCode == 6'h2b || (OpCode == 6'h04 || OpCode == 6'h07 || OpCode == 6'h06 || OpCode == 6'h01 || OpCode == 6'h05) || OpCode == 6'h02 || OpCode == 0 && Funct == 6'h08)?0:1;
    assign RegDst = (OpCode == 0 || OpCode == 6'h1c)?1:(OpCode == 6'h03)?2:0;
    assign MemRead = (OpCode == 6'h23)?1:0;
    assign MemWrite = (OpCode == 6'h2b)?1:0;
    assign MemtoReg = (OpCode == 6'h23)?1:(OpCode == 6'h03 || OpCode == 0 && Funct == 6'h09)?2:0;
    assign ALUSrc1 = (OpCode == 0 && (Funct == 0 || Funct == 6'h02 || Funct == 6'h03))?1:0;
    assign ALUSrc2 = (OpCode == 0 || (OpCode == 6'h04 || OpCode == 6'h07 || OpCode == 6'h06 || OpCode == 6'h01 || OpCode == 6'h05) || OpCode == 6'h1c)?0:1;
    assign ExtOp = (OpCode == 6'h0f || OpCode == 6'h0c)?0:1;
    assign LuOp = (OpCode == 6'h0f)?1:0;


    // Your code above (for question 1)

    assign ALUOp[2:0] =
           (OpCode == 6'h00)? 3'b010:
           (OpCode == 6'h04)? 3'b001:
           (OpCode == 6'h0c)? 3'b100:
           (OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101:
           3'b000;

    assign ALUOp[3] = OpCode[0];

    assign BranchType =
           (OpCode == 6'h07)? 3'b000: // bgtz
           (OpCode == 6'h06)? 3'b001: // blez
           (OpCode == 6'h01)? 3'b010: // bltz
           (OpCode == 6'h05)? 3'b011: // bne
           3'b100; // normal

    // Add your code above (for question 2)

endmodule
