module CPU(
        input clk,
        input rst,
        output memRead_MEM,
        output memWrite_MEM,
        output [31:0] memAddr,
        output [31:0] memDat,
        input [31:0] deviceData
    );

    // IF
    wire [31:0] PC;
    wire [31:0] PC4;
    assign PC4 = PC + 4;

    wire [1:0] PCSrc;
    wire [31:0] branchAddr;
    wire [31:0] jumpAddr;
    wire [31:0] regAddr;
    wire [31:0] newPC;

    wire[1:0] PCControl;

    assign newPC = (PCControl == 2'b00)? branchAddr: (PCControl == 2'b01)? jumpAddr: regAddr;

    wire [31:0] PCIn;
    wire [1:0] PCFlush;

    RegBetween #(32) PCReg(clk, rst, PCIn, PC, PCFlush);

    assign PCIn = newPC;

    wire [31:0] instruction;
    InstructionMemory IM(PC, instruction);

    // ID

    wire[31:0] PC4_ID;
    wire[31:0] instruction_ID;
    wire[1:0] IFIDFlush;
    RegBetween #(32 + 32) IFID(clk, rst, {PC4, instruction}, {PC4_ID, instruction_ID}, IFIDFlush);

    wire branch, regWrite, ALUSrc1, ALUSrc2, ExtOp, LuOp, memRead, memWrite;
    wire [1:0] memtoReg;
    wire [1:0] regDst;
    wire [3:0] ALUOp;
    wire [2:0] branchType;
    Control control(instruction_ID[31:26], instruction_ID[5:0],
                    PCSrc, branch, regWrite, regDst,
                    memRead, memWrite, memtoReg,
                    ALUSrc1, ALUSrc2, ExtOp, LuOp, ALUOp, branchType);

    wire regWrite_WB;
    wire [4:0] readAddr1;
    wire [4:0] readAddr2;
    wire [4:0] writeAddr;
    wire [31:0] writeData;
    wire [31:0] readData1;
    wire [31:0] readData2;

    assign readAddr1 = instruction_ID[25:21];
    assign readAddr2 = instruction_ID[20:16];

    RegisterFile RF(rst, clk, regWrite_WB, readAddr1, readAddr2, writeAddr, writeData, readData1, readData2);

    assign regAddr = readData1;
    assign jumpAddr = {PC4_ID[31:28], instruction_ID[25:0], 2'b00};

    wire[31:0] signExtend;
    assign signExtend = { ExtOp? {16{instruction_ID[15]}}: 16'h0000, instruction_ID[15:0]};

    wire[31:0] luExtend;
    assign luExtend = LuOp? {instruction_ID[15:0], 16'h0000}: signExtend;

    // EX

    wire [1:0] IDEXFlush;
    wire ALUSrc1_EX, ALUSrc2_EX, memWrite_EX, branch_EX, regWrite_EX, memRead_EX;
    wire [1:0] regDst_EX, memtoReg_EX;
    wire [3:0] ALUOp_EX;
    wire [31:0] readData1_EX;
    wire [31:0] readData2_EX;
    wire [31:0] luExtend_EX;
    wire [31:0] aluSrcA;
    wire [31:0] aluSrcB;
    wire [31:0] PC4_EX;
    wire [31:0] writeDataForward;
    wire [5:0] funcT;
    wire [4:0] shamt;
    wire [2:0] branchType_EX;
    wire [4:0] writeAddr1, writeAddr2, readAddr; // writeAddr1 = rt, writeAddr2 = rd, readAddr = rs
    RegBetween #(32+32+32+32+1+1+1+4+2+1+1+2+1+3+6+5+5+5+5) IDEX(clk, rst,
               {PC4_ID, readData1, readData2, luExtend, ALUSrc1, ALUSrc2, memRead, ALUOp, regDst, memWrite, branch, memtoReg, regWrite, branchType, instruction_ID[5:0], readAddr2, instruction_ID[15:11], readAddr1, instruction_ID[10:6]},
               {PC4_EX, readData1_EX, readData2_EX, luExtend_EX, ALUSrc1_EX, ALUSrc2_EX, memRead_EX, ALUOp_EX, regDst_EX, memWrite_EX, branch_EX, memtoReg_EX, regWrite_EX, branchType_EX, funcT, writeAddr1, writeAddr2, readAddr, shamt},
               IDEXFlush);

    wire [31:0] ALUResult;
    wire zero, sign;
    wire[4:0] ALUCtl;
    ALUControl aluControl(ALUOp_EX, funcT, ALUCtl, sign);

    wire [31:0] aluInputA, aluInputB;

    assign aluSrcA = (ALUSrc1_EX)? {27'h00000, shamt}: readData1_EX;
    assign aluSrcB = (ALUSrc2_EX)? luExtend_EX: readData2_EX;
    ALU alu(aluInputA, aluInputB, ALUCtl, sign, branchType_EX, ALUResult, zero);

    assign PCControl = (branch_EX && zero)?2'b00:PCSrc;

    assign branchAddr = (zero && branch_EX)? PC4_EX + (luExtend_EX << 2): PC4;

    wire [4:0] writeBackAddr;
    assign writeBackAddr = (regDst_EX == 2'b00)? writeAddr1: (regDst_EX==2'b01)?writeAddr2: 5'b11111;

    // MEM

    wire regWrite_MEM;
    wire [1:0] memtoReg_MEM;
    wire [31:0] ALUResult_MEM;
    wire [31:0] readData2_MEM;
    wire [4:0] writeBackAddr_MEM;
    wire [31:0] memData;
    wire [31:0] PC4_MEM;

    wire [31:0] readMemData;

    RegBetween #(32+32+32+1+2+1+1+5) EXMEM(clk, rst,{ALUResult, writeDataForward, PC4_EX, memWrite_EX, memtoReg_EX, regWrite_EX, memRead_EX,  writeBackAddr},
                                           {ALUResult_MEM, readData2_MEM, PC4_MEM, memWrite_MEM, memtoReg_MEM, regWrite_MEM, memRead_MEM,  writeBackAddr_MEM}, 2'b00);

    assign readMemData = (ALUResult_MEM[31:28] == 4'h4)? deviceData: memData;

    wire DMmemRead, DMmemWrite;

    assign DMmemWrite = (ALUResult_MEM[31:28] == 4'h4)? 0 : memWrite_MEM;
    assign DMmemRead = (ALUResult_MEM[31:28] == 4'h4)? 0 : memRead_MEM;

    DataMemory DM(rst, clk, DMmemRead, DMmemWrite, ALUResult_MEM, readData2_MEM, memData);

    assign memAddr = (ALUResult_MEM[31:28] == 4'h4)? ALUResult_MEM : 0;
    assign memDat = (ALUResult_MEM[31:28] == 4'h4)? readData2_MEM : 0;

    // WB

    wire [1:0] memtoReg_WB;
    wire [31:0] ALUResult_WB;
    wire [31:0] memData_WB;
    wire [4:0] writeBackAddr_WB;
    wire [31:0] PC4_WB;
    RegBetween #(32+32+32+2+1+5) MEMWB(clk, rst, {PC4_MEM, readMemData, ALUResult_MEM, memtoReg_MEM, regWrite_MEM, writeBackAddr_MEM},
                                       {PC4_WB, memData_WB, ALUResult_WB, memtoReg_WB, regWrite_WB, writeBackAddr_WB}, 2'b00);

    assign writeAddr = writeBackAddr_WB;

    assign writeData = (memtoReg_WB == 2'b00)? ALUResult_WB: (memtoReg_WB == 2'b01)? memData_WB: PC4_WB;

    // Forward Unit

    wire [1:0] forwardCtlA, forwardCtlB;

    ForwardUnit forwardA(writeBackAddr_MEM, writeBackAddr_WB, readAddr, regWrite_MEM, regWrite_WB, forwardCtlA);
    ForwardUnit forwardB(writeBackAddr_MEM, writeBackAddr_WB, writeAddr1, regWrite_MEM, regWrite_WB, forwardCtlB);


    assign aluInputA = (forwardCtlA==2'b00 || ALUSrc1_EX)?aluSrcA:(forwardCtlA==2'b01)?writeData:(forwardCtlA == 2'b10)?ALUResult_MEM:0;
    assign aluInputB = (forwardCtlB==2'b00 || ALUSrc2_EX)?aluSrcB:(forwardCtlB==2'b01)?writeData:(forwardCtlB == 2'b10)?ALUResult_MEM:0;

    assign writeDataForward = (forwardCtlB==2'b00)?readData2_EX:(forwardCtlB==2'b01)?writeData:(forwardCtlB == 2'b10)?ALUResult_MEM:0;

    // Hazard Unit

    Hazard hazardUnit(writeAddr1, readAddr1, readAddr2, branch, branch_EX, zero, memRead_EX, PCSrc, PCFlush, IFIDFlush, IDEXFlush);

endmodule
