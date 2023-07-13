
module InstructionMemory(Address, Instruction);
    input [31:0] Address;
    output reg [31:0] Instruction;

    always @(*)
    case (Address[9:2])

        8'd0:
            Instruction <= 32'h24080000;
        8'd1:
            Instruction <= 32'h8d100000;
        8'd2:
            Instruction <= 32'h00102021;
        8'd3:
            Instruction <= 32'h21050004;
        8'd4:
            Instruction <= 32'h0c100065;
        8'd5:
            Instruction <= 32'h24081004;
        8'd6:
            Instruction <= 32'h24090000;
        8'd7:
            Instruction <= 32'h00008821;
        8'd8:
            Instruction <= 32'h00105880;
        8'd9:
            Instruction <= 32'h012b082a;
        8'd10:
            Instruction <= 32'h10200005;
        8'd11:
            Instruction <= 32'h01286020;
        8'd12:
            Instruction <= 32'h8d8a0000;
        8'd13:
            Instruction <= 32'h022a8820;
        8'd14:
            Instruction <= 32'h21290004;
        8'd15:
            Instruction <= 32'h08100009;
        8'd16:
            Instruction <= 32'h24120000;
        8'd17:
            Instruction <= 32'h2229fc18;
        8'd18:
            Instruction <= 32'h0120082a;
        8'd19:
            Instruction <= 32'h14200003;
        8'd20:
            Instruction <= 32'h22520001;
        8'd21:
            Instruction <= 32'h2231fc18;
        8'd22:
            Instruction <= 32'h08100011;
        8'd23:
            Instruction <= 32'h24130000;
        8'd24:
            Instruction <= 32'h2229ff9c;
        8'd25:
            Instruction <= 32'h0120082a;
        8'd26:
            Instruction <= 32'h14200003;
        8'd27:
            Instruction <= 32'h22730001;
        8'd28:
            Instruction <= 32'h2231ff9c;
        8'd29:
            Instruction <= 32'h08100018;
        8'd30:
            Instruction <= 32'h24140000;
        8'd31:
            Instruction <= 32'h2229fff6;
        8'd32:
            Instruction <= 32'h0120082a;
        8'd33:
            Instruction <= 32'h14200003;
        8'd34:
            Instruction <= 32'h22940001;
        8'd35:
            Instruction <= 32'h2231fff6;
        8'd36:
            Instruction <= 32'h0810001f;
        8'd37:
            Instruction <= 32'h0011a821;
        8'd38:
            Instruction <= 32'h2408003f;
        8'd39:
            Instruction <= 32'hac080000;
        8'd40:
            Instruction <= 32'h24080006;
        8'd41:
            Instruction <= 32'hac080004;
        8'd42:
            Instruction <= 32'h2408005b;
        8'd43:
            Instruction <= 32'hac080008;
        8'd44:
            Instruction <= 32'h2408004f;
        8'd45:
            Instruction <= 32'hac08000c;
        8'd46:
            Instruction <= 32'h24080066;
        8'd47:
            Instruction <= 32'hac080010;
        8'd48:
            Instruction <= 32'h2408006d;
        8'd49:
            Instruction <= 32'hac080014;
        8'd50:
            Instruction <= 32'h2408007d;
        8'd51:
            Instruction <= 32'hac080018;
        8'd52:
            Instruction <= 32'h24080007;
        8'd53:
            Instruction <= 32'hac08001c;
        8'd54:
            Instruction <= 32'h2408007f;
        8'd55:
            Instruction <= 32'hac080020;
        8'd56:
            Instruction <= 32'h2408006f;
        8'd57:
            Instruction <= 32'hac080024;
        8'd58:
            Instruction <= 32'h00129080;
        8'd59:
            Instruction <= 32'h00139880;
        8'd60:
            Instruction <= 32'h0014a080;
        8'd61:
            Instruction <= 32'h0015a880;
        8'd62:
            Instruction <= 32'h8e520000;
        8'd63:
            Instruction <= 32'h8e730000;
        8'd64:
            Instruction <= 32'h8e940000;
        8'd65:
            Instruction <= 32'h8eb50000;
        8'd66:
            Instruction <= 32'h22b50100;
        8'd67:
            Instruction <= 32'h22940200;
        8'd68:
            Instruction <= 32'h22730400;
        8'd69:
            Instruction <= 32'h22520800;
        8'd70:
            Instruction <= 32'h24090000;
        8'd71:
            Instruction <= 32'h240a030c;
        8'd72:
            Instruction <= 32'h3c0b4000;
        8'd73:
            Instruction <= 32'h216b0010;
        8'd74:
            Instruction <= 32'h240c0000;
        8'd75:
            Instruction <= 32'h3c010001;
        8'd76:
            Instruction <= 32'h342dbf52;
        8'd77:
            Instruction <= 32'h218c0001;
        8'd78:
            Instruction <= 32'h018d082a;
        8'd79:
            Instruction <= 32'h1020005b;
        8'd80:
            Instruction <= 32'h0132082a;
        8'd81:
            Instruction <= 32'h10200003;
        8'd82:
            Instruction <= 32'had750000;
        8'd83:
            Instruction <= 32'h21290001;
        8'd84:
            Instruction <= 32'h08100050;
        8'd85:
            Instruction <= 32'h0120082a;
        8'd86:
            Instruction <= 32'h14200003;
        8'd87:
            Instruction <= 32'had740000;
        8'd88:
            Instruction <= 32'h2129ffff;
        8'd89:
            Instruction <= 32'h08100055;
        8'd90:
            Instruction <= 32'h012a082a;
        8'd91:
            Instruction <= 32'h10200003;
        8'd92:
            Instruction <= 32'had730000;
        8'd93:
            Instruction <= 32'h21290001;
        8'd94:
            Instruction <= 32'h0810005a;
        8'd95:
            Instruction <= 32'h0120082a;
        8'd96:
            Instruction <= 32'h1420ffec;
        8'd97:
            Instruction <= 32'had720000;
        8'd98:
            Instruction <= 32'h2129ffff;
        8'd99:
            Instruction <= 32'h0810005f;
        8'd100:
            Instruction <= 32'h081000ab;
        8'd101:
            Instruction <= 32'h24141004;
        8'd102:
            Instruction <= 32'h24111084;
        8'd103:
            Instruction <= 32'hae800000;
        8'd104:
            Instruction <= 32'h24080001;
        8'd105:
            Instruction <= 32'hae280000;
        8'd106:
            Instruction <= 32'h00042080;
        8'd107:
            Instruction <= 32'h24080004;
        8'd108:
            Instruction <= 32'h0104082a;
        8'd109:
            Instruction <= 32'h10200008;
        8'd110:
            Instruction <= 32'h01144820;
        8'd111:
            Instruction <= 32'h01055020;
        8'd112:
            Instruction <= 32'h8d4a0000;
        8'd113:
            Instruction <= 32'had2a0000;
        8'd114:
            Instruction <= 32'h01115820;
        8'd115:
            Instruction <= 32'had600000;
        8'd116:
            Instruction <= 32'h21080004;
        8'd117:
            Instruction <= 32'h0810006c;
        8'd118:
            Instruction <= 32'h24080004;
        8'd119:
            Instruction <= 32'h0104082a;
        8'd120:
            Instruction <= 32'h10200031;
        8'd121:
            Instruction <= 32'h24090004;
        8'd122:
            Instruction <= 32'h2413ffff;
        8'd123:
            Instruction <= 32'h2412ffff;
        8'd124:
            Instruction <= 32'h0124082a;
        8'd125:
            Instruction <= 32'h1020000f;
        8'd126:
            Instruction <= 32'h01315020;
        8'd127:
            Instruction <= 32'h8d4a0000;
        8'd128:
            Instruction <= 32'h1540000a;
        8'd129:
            Instruction <= 32'h01345020;
        8'd130:
            Instruction <= 32'h8d4a0000;
        8'd131:
            Instruction <= 32'h240bffff;
        8'd132:
            Instruction <= 32'h114b0006;
        8'd133:
            Instruction <= 32'h126b0003;
        8'd134:
            Instruction <= 32'h0153082a;
        8'd135:
            Instruction <= 32'h14200001;
        8'd136:
            Instruction <= 32'h0810008b;
        8'd137:
            Instruction <= 32'h000a9821;
        8'd138:
            Instruction <= 32'h00099021;
        8'd139:
            Instruction <= 32'h21290004;
        8'd140:
            Instruction <= 32'h0810007c;
        8'd141:
            Instruction <= 32'h2409ffff;
        8'd142:
            Instruction <= 32'h1133001b;
        8'd143:
            Instruction <= 32'h02515020;
        8'd144:
            Instruction <= 32'h240b0001;
        8'd145:
            Instruction <= 32'had4b0000;
        8'd146:
            Instruction <= 32'h240c0004;
        8'd147:
            Instruction <= 32'h0184082a;
        8'd148:
            Instruction <= 32'h10200013;
        8'd149:
            Instruction <= 32'h01916820;
        8'd150:
            Instruction <= 32'h8dad0000;
        8'd151:
            Instruction <= 32'h15a0000e;
        8'd152:
            Instruction <= 32'h00126940;
        8'd153:
            Instruction <= 32'h01ac6820;
        8'd154:
            Instruction <= 32'h01a56820;
        8'd155:
            Instruction <= 32'h8dad0000;
        8'd156:
            Instruction <= 32'h11a90009;
        8'd157:
            Instruction <= 32'h01947020;
        8'd158:
            Instruction <= 32'h8dce0000;
        8'd159:
            Instruction <= 32'h026d7820;
        8'd160:
            Instruction <= 32'h11c90003;
        8'd161:
            Instruction <= 32'h01ee082a;
        8'd162:
            Instruction <= 32'h14200001;
        8'd163:
            Instruction <= 32'h081000a6;
        8'd164:
            Instruction <= 32'h01947020;
        8'd165:
            Instruction <= 32'hadcf0000;
        8'd166:
            Instruction <= 32'h218c0004;
        8'd167:
            Instruction <= 32'h08100093;
        8'd168:
            Instruction <= 32'h21080004;
        8'd169:
            Instruction <= 32'h08100077;
        8'd170:
            Instruction <= 32'h03e00008;
        8'd171:
            Instruction <= 32'h081000ab;


        default:
            Instruction <= 32'h00000000;
    endcase

endmodule
