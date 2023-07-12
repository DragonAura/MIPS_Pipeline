module Hazard(
        input [4:0] IDEXRt,
        input [4:0] IFIDRs,
        input [4:0] IFIDRt,
        input branch_ID,
        input branch_EX,
        input zero,
        input memRead,
        input [1:0] PCSrcID,
        output [1:0] PCFlush,
        output [1:0] IFIDFlush,
        output [1:0] IDEXFlush
    );

    assign PCFlush = ((IDEXRt == IFIDRs || IDEXRt == IFIDRt) && memRead)? 2'b10: 2'b00;
    assign IFIDFlush = ((IDEXRt == IFIDRs || IDEXRt == IFIDRt) && memRead)? 2'b10: (PCSrcID == 2'b01 || PCSrcID == 2'b10 || (zero && branch_EX))? 2'b01: 2'b00;
    assign IDEXFlush = ((zero && branch_EX) || ((IDEXRt == IFIDRs || IDEXRt == IFIDRt) && memRead))? 2'b01: 2'b00;
endmodule
