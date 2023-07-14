module DataMemory(
        input  reset    ,
        input  clk      ,
        input  MemRead  ,
        input  MemWrite ,
        input  [32 -1:0] Address    ,
        input  [32 -1:0] Write_data ,
        output [32 -1:0] readData
    );
    
    wire [31:0] RAMData;
    assign readData = (MemRead)? RAMData : 0;
    
    RAMModule ram(.addra(Address[12:2]), .clka(clk), .dina(Write_data), .douta(RAMData), .wea(MemWrite));

endmodule
