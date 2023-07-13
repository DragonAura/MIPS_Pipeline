module top(
        input clk,
        input rst,
        input RX_Serial,
        output TX_Serial,
        output [6:0] leds,
        output [3:0] ano,
        output dot
    );

    wire divideClk, locked;
    wire memRead, memWrite;

    assign locked = 0;

    FreqDivide freq(divideClk, rst, locked, clk);

    wire [31:0] memAddr;
    wire [31:0] memData;
    wire [31:0] deviceData;
    CPU cpu(
            .clk(divideClk),
            .rst(rst),
            .memRead_MEM(memRead),
            .memWrite_MEM(memWrite),
            .memAddr(memAddr),
            .memDat(memData),
            .deviceData(deviceData)
        );

    LED led(
            .clk(divideClk),
            .rst(rst),
            .memWrite(memWrite),
            .dataIn(memData),
            .address(memAddr),
            .digi({ano, dot, leds})
        );

    UART uart(
             .clk(divideClk),
             .rst(rst),
             .rx(RX_Serial),
             .memRead(memRead),
             .memWrite(memWrite),
             .dataIn(memData),
             .address(memAddr),
             .uartData(deviceData),
             .tx(TX_Serial)
         );

endmodule
