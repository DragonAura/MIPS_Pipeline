
module InstructionMemory(Address, Instruction);
    input [31:0] Address;
    output reg [31:0] Instruction;

    always @(*)
    case (Address[9:2])

        // Paste Binary Instruction Below (Inst-q1.txt, Inst-q2.txt, Inst-q3.txt)
        8'd0:
            Instruction <= 32'h24080000;
        8'd1:
            Instruction <= 32'h8d100000;
        8'd2:
            Instruction <= 32'h00102021;
        8'd3:
            Instruction <= 32'h21050004;
        8'd4:
            Instruction <= 32'h0c10000b;
        8'd5:
            Instruction <= 32'h24081004;
        8'd6:
            Instruction <= 32'h8d090000;
        8'd7:
            Instruction <= 32'h8d0a0004;
        8'd8:
            Instruction <= 32'h8d0b0008;
        8'd9:
            Instruction <= 32'h8d0c000c;
        8'd10:
            Instruction <= 32'h08100051;
        8'd11:
            Instruction <= 32'h24141004;
        8'd12:
            Instruction <= 32'h24111084;
        8'd13:
            Instruction <= 32'hae800000;
        8'd14:
            Instruction <= 32'h24080001;
        8'd15:
            Instruction <= 32'hae280000;
        8'd16:
            Instruction <= 32'h00042080;
        8'd17:
            Instruction <= 32'h24080004;
        8'd18:
            Instruction <= 32'h0104082a;
        8'd19:
            Instruction <= 32'h10200008;
        8'd20:
            Instruction <= 32'h01144820;
        8'd21:
            Instruction <= 32'h01055020;
        8'd22:
            Instruction <= 32'h8d4a0000;
        8'd23:
            Instruction <= 32'had2a0000;
        8'd24:
            Instruction <= 32'h01115820;
        8'd25:
            Instruction <= 32'had600000;
        8'd26:
            Instruction <= 32'h21080004;
        8'd27:
            Instruction <= 32'h08100012;
        8'd28:
            Instruction <= 32'h24080004;
        8'd29:
            Instruction <= 32'h0104082a;
        8'd30:
            Instruction <= 32'h10200031;
        8'd31:
            Instruction <= 32'h24090004;
        8'd32:
            Instruction <= 32'h2413ffff;
        8'd33:
            Instruction <= 32'h2412ffff;
        8'd34:
            Instruction <= 32'h0124082a;
        8'd35:
            Instruction <= 32'h1020000f;
        8'd36:
            Instruction <= 32'h01315020;
        8'd37:
            Instruction <= 32'h8d4a0000;
        8'd38:
            Instruction <= 32'h1540000a;
        8'd39:
            Instruction <= 32'h01345020;
        8'd40:
            Instruction <= 32'h8d4a0000;
        8'd41:
            Instruction <= 32'h240bffff;
        8'd42:
            Instruction <= 32'h114b0006;
        8'd43:
            Instruction <= 32'h126b0003;
        8'd44:
            Instruction <= 32'h0153082a;
        8'd45:
            Instruction <= 32'h14200001;
        8'd46:
            Instruction <= 32'h08100031;
        8'd47:
            Instruction <= 32'h000a9821;
        8'd48:
            Instruction <= 32'h00099021;
        8'd49:
            Instruction <= 32'h21290004;
        8'd50:
            Instruction <= 32'h08100022;
        8'd51:
            Instruction <= 32'h2409ffff;
        8'd52:
            Instruction <= 32'h1133001b;
        8'd53:
            Instruction <= 32'h02515020;
        8'd54:
            Instruction <= 32'h240b0001;
        8'd55:
            Instruction <= 32'had4b0000;
        8'd56:
            Instruction <= 32'h240c0004;
        8'd57:
            Instruction <= 32'h0184082a;
        8'd58:
            Instruction <= 32'h10200013;
        8'd59:
            Instruction <= 32'h01916820;
        8'd60:
            Instruction <= 32'h8dad0000;
        8'd61:
            Instruction <= 32'h15a0000e;
        8'd62:
            Instruction <= 32'h00126940;
        8'd63:
            Instruction <= 32'h01ac6820;
        8'd64:
            Instruction <= 32'h01a56820;
        8'd65:
            Instruction <= 32'h8dad0000;
        8'd66:
            Instruction <= 32'h11a90009;
        8'd67:
            Instruction <= 32'h01947020;
        8'd68:
            Instruction <= 32'h8dce0000;
        8'd69:
            Instruction <= 32'h026d7820;
        8'd70:
            Instruction <= 32'h11c90003;
        8'd71:
            Instruction <= 32'h01ee082a;
        8'd72:
            Instruction <= 32'h14200001;
        8'd73:
            Instruction <= 32'h0810004c;
        8'd74:
            Instruction <= 32'h01947020;
        8'd75:
            Instruction <= 32'hadcf0000;
        8'd76:
            Instruction <= 32'h218c0004;
        8'd77:
            Instruction <= 32'h08100039;
        8'd78:
            Instruction <= 32'h21080004;
        8'd79:
            Instruction <= 32'h0810001d;
        8'd80:
            Instruction <= 32'h03e00008;
        8'd81:
            Instruction <= 32'h08100051;


        // Paste Binary Instruction Above

        default:
            Instruction <= 32'h00000000;
    endcase

endmodule
