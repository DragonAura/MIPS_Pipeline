module UART(
        input clk,
        input rst,
        input rx,
        input memRead,
        input memWrite,
        input [31:0] dataIn,
        input [31:0] address,
        output [31:0] uartData,
        output tx
    );
    reg [31:0] dataToUART;
    reg [31:0] dataToCPU;
    reg [2:0] UARTControl;
    wire rxFinish;
    reg txStart;
    wire txActive;
    wire txDone;
    wire [7:0] rxData;

    uart_rx rxUnit(
                .i_Clock(clk),
                .i_Rx_Serial(rx),
                .o_Rx_DV(rxFinish),
                .o_Rx_Byte(rxData)
            );

    uart_tx txUnit(
                .i_Clock(clk),
                .i_Tx_DV(txStart),
                .o_Tx_Serial(tx),
                .i_Tx_Byte(dataToUART[7:0]),
                .o_Tx_Active(txActive),
                .o_Tx_Done(txDone)
            );



    assign uartData = (address == 32'h4000001c && memRead)? dataToCPU : (address == 32'h40000020 && memRead)? {28'h0, UARTControl, 1'b0} : 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            txStart <= 0;
            dataToUART <= 0;
            dataToCPU <= 0;
            UARTControl <= 0;
        end
        else begin
            case (address)
                32'h40000018:
                    if (memWrite) begin
                        dataToUART <= dataIn;
                        txStart <= 1;
                    end
                32'h4000001c:
                    ;
                32'h40000020:
                    if (memRead) begin
                        if (UARTControl[0] == 1)
                            UARTControl[0] <= 0;
                        if (UARTControl[1] == 1)
                            UARTControl[1] <= 0;
                    end
                default:
                    ;
            endcase

            if (rxFinish) begin
                dataToCPU <= {24'h0, rxData};
                // dataToUART <= {24'h0, rxData};
                UARTControl[1] <= 1;
            end

            if (txDone) begin
                UARTControl[0] <= 1;
                UARTControl[2] <= 0;
                txStart <= 0;
            end

            if (txActive)
                UARTControl[2] <= 1;

        end
    end

endmodule
