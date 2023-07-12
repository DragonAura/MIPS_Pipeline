module DataMemory(
        input  reset    ,
        input  clk      ,
        input  MemRead  ,
        input  MemWrite ,
        input  [32 -1:0] Address    ,
        input  [32 -1:0] Write_data ,
        output [32 -1:0] Read_data
    );

    // RAM size is 256 words, each word is 32 bits, valid address is 8 bits
    parameter RAM_SIZE      = 1100;
     parameter RAM_SIZE_BIT  = 13;

    // RAM_data is an array of 256 32-bit registers
    reg [31:0] RAM_data [RAM_SIZE - 1: 0];

    // read data from RAM_data as Read_data
    assign Read_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;

    // write Write_data to RAM_data at clock posedge

    integer i;
    always @(posedge reset or posedge clk)
        if (reset) begin
            for (i = 0; i < RAM_SIZE; i = i + 1)
                RAM_data[i] <= 32'h00000000;
            RAM_data[0] <= 5;
            RAM_data[2] <= 97;
            RAM_data[3] <= -1;
            RAM_data[4] <= -1;
            RAM_data[5] <= 21;
            RAM_data[33] <= 97;
            RAM_data[35] <= 30;
            RAM_data[36] <= 100;
            RAM_data[37] <= 32;
            RAM_data[65] <= -1;
            RAM_data[66] <= 30;
            RAM_data[68] <= 81;
            RAM_data[68] <= 98;
            RAM_data[97] <= -1;
            RAM_data[98] <= 100;
            RAM_data[99] <= 81;
            RAM_data[101] <= 69;
            RAM_data[129] <= 21;
            RAM_data[130] <= 32;
            RAM_data[131] <= 98;
            RAM_data[132] <= 69;
        end
        else if (MemWrite)
            RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;

endmodule
