module top(
        input clk,
        input rst,
        output [6:0] leds,
        output [3:0] ano,
        output dot
    );
    
    wire divideClk, locked;
    
    assign locked = 0;
    
    FreqDivide freq(divideClk, rst, locked, clk);
    
    wire [31:0] memAddr;
    wire [31:0] memData;
    wire [31:0] deviceData;
    CPU cpu(
            .clk(divideClk),
            .rst(rst),
            .memAddr(memAddr),
            .memDat(memData),
            .deviceData(deviceData)
        );

    LED led(
            .clk(divideClk),
            .rst(rst),
            .dataIn(memData),
            .address(memAddr),
            .digi({ano, dot, leds})
        );

endmodule
