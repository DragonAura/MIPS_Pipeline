
module InstructionMemory(Address, Instruction);
    input [31:0] Address;
    output reg [31:0] Instruction;

    always @(*)
    case (Address[10:2])
        9'd0:
            Instruction <= 32'h3c094000;
        9'd1:
            Instruction <= 32'h212a0020;
        9'd2:
            Instruction <= 32'h8d4b0000;
        9'd3:
            Instruction <= 32'h316b0004;
        9'd4:
            Instruction <= 32'h1160fffd;
        9'd5:
            Instruction <= 32'h212c001c;
        9'd6:
            Instruction <= 32'h8d8d0000;
        9'd7:
            Instruction <= 32'h000d6a00;
        9'd8:
            Instruction <= 32'h8d4b0000;
        9'd9:
            Instruction <= 32'h316b0004;
        9'd10:
            Instruction <= 32'h1160fffd;
        9'd11:
            Instruction <= 32'h212c001c;
        9'd12:
            Instruction <= 32'h8d8e0000;
        9'd13:
            Instruction <= 32'h01ae6825;
        9'd14:
            Instruction <= 32'h000d6c00;
        9'd15:
            Instruction <= 32'h8d4b0000;
        9'd16:
            Instruction <= 32'h316b0004;
        9'd17:
            Instruction <= 32'h1160fffd;
        9'd18:
            Instruction <= 32'h212c001c;
        9'd19:
            Instruction <= 32'h8d8e0000;
        9'd20:
            Instruction <= 32'h000e7200;
        9'd21:
            Instruction <= 32'h01ae6825;
        9'd22:
            Instruction <= 32'h8d4b0000;
        9'd23:
            Instruction <= 32'h316b0004;
        9'd24:
            Instruction <= 32'h1160fffd;
        9'd25:
            Instruction <= 32'h212c001c;
        9'd26:
            Instruction <= 32'h8d8e0000;
        9'd27:
            Instruction <= 32'h01ae6825;
        9'd28:
            Instruction <= 32'h240e0020;
        9'd29:
            Instruction <= 32'h11a0ffe2;
        9'd30:
            Instruction <= 32'h01ae082a;
        9'd31:
            Instruction <= 32'h1020ffe0;
        9'd32:
            Instruction <= 32'hac0d0000;
        9'd33:
            Instruction <= 32'h000d8821;
        9'd34:
            Instruction <= 32'h24120000;
        9'd35:
            Instruction <= 32'h24130000;
        9'd36:
            Instruction <= 32'h24140004;
        9'd37:
            Instruction <= 32'h0251082a;
        9'd38:
            Instruction <= 32'h10200028;
        9'd39:
            Instruction <= 32'h0012b1c0;
        9'd40:
            Instruction <= 32'h24130000;
        9'd41:
            Instruction <= 32'h0271082a;
        9'd42:
            Instruction <= 32'h10200022;
        9'd43:
            Instruction <= 32'h3c094000;
        9'd44:
            Instruction <= 32'h212a0020;
        9'd45:
            Instruction <= 32'h8d4b0000;
        9'd46:
            Instruction <= 32'h316b0004;
        9'd47:
            Instruction <= 32'h1160fffd;
        9'd48:
            Instruction <= 32'h212c001c;
        9'd49:
            Instruction <= 32'h8d8d0000;
        9'd50:
            Instruction <= 32'h000d6a00;
        9'd51:
            Instruction <= 32'h8d4b0000;
        9'd52:
            Instruction <= 32'h316b0004;
        9'd53:
            Instruction <= 32'h1160fffd;
        9'd54:
            Instruction <= 32'h212c001c;
        9'd55:
            Instruction <= 32'h8d8e0000;
        9'd56:
            Instruction <= 32'h01ae6825;
        9'd57:
            Instruction <= 32'h000d6c00;
        9'd58:
            Instruction <= 32'h8d4b0000;
        9'd59:
            Instruction <= 32'h316b0004;
        9'd60:
            Instruction <= 32'h1160fffd;
        9'd61:
            Instruction <= 32'h212c001c;
        9'd62:
            Instruction <= 32'h8d8e0000;
        9'd63:
            Instruction <= 32'h000e7200;
        9'd64:
            Instruction <= 32'h01ae6825;
        9'd65:
            Instruction <= 32'h8d4b0000;
        9'd66:
            Instruction <= 32'h316b0004;
        9'd67:
            Instruction <= 32'h1160fffd;
        9'd68:
            Instruction <= 32'h212c001c;
        9'd69:
            Instruction <= 32'h8d8e0000;
        9'd70:
            Instruction <= 32'h01ae6825;
        9'd71:
            Instruction <= 32'h0013b880;
        9'd72:
            Instruction <= 32'h02f6b820;
        9'd73:
            Instruction <= 32'h02f4b820;
        9'd74:
            Instruction <= 32'haeed0000;
        9'd75:
            Instruction <= 32'h22730001;
        9'd76:
            Instruction <= 32'h08100029;
        9'd77:
            Instruction <= 32'h22520001;
        9'd78:
            Instruction <= 32'h08100025;
        9'd79:
            Instruction <= 32'h24080000;
        9'd80:
            Instruction <= 32'h8d100000;
        9'd81:
            Instruction <= 32'h00102021;
        9'd82:
            Instruction <= 32'h21050004;
        9'd83:
            Instruction <= 32'h0c1000d1;
        9'd84:
            Instruction <= 32'h24081004;
        9'd85:
            Instruction <= 32'h24090000;
        9'd86:
            Instruction <= 32'h00008821;
        9'd87:
            Instruction <= 32'h00105880;
        9'd88:
            Instruction <= 32'h012b082a;
        9'd89:
            Instruction <= 32'h10200025;
        9'd90:
            Instruction <= 32'h01287020;
        9'd91:
            Instruction <= 32'h8dca0000;
        9'd92:
            Instruction <= 32'h3c124000;
        9'd93:
            Instruction <= 32'h22520020;
        9'd94:
            Instruction <= 32'h8e4c0000;
        9'd95:
            Instruction <= 32'h318c0008;
        9'd96:
            Instruction <= 32'h1580fffd;
        9'd97:
            Instruction <= 32'h000a6e02;
        9'd98:
            Instruction <= 32'hae4dfff8;
        9'd99:
            Instruction <= 32'h00000000;
        9'd100:
            Instruction <= 32'h00000000;
        9'd101:
            Instruction <= 32'h8e4c0000;
        9'd102:
            Instruction <= 32'h318c0008;
        9'd103:
            Instruction <= 32'h1580fffd;
        9'd104:
            Instruction <= 32'h000a6c02;
        9'd105:
            Instruction <= 32'h31ad00ff;
        9'd106:
            Instruction <= 32'hae4dfff8;
        9'd107:
            Instruction <= 32'h00000000;
        9'd108:
            Instruction <= 32'h00000000;
        9'd109:
            Instruction <= 32'h8e4c0000;
        9'd110:
            Instruction <= 32'h318c0008;
        9'd111:
            Instruction <= 32'h1580fffd;
        9'd112:
            Instruction <= 32'h000a6a02;
        9'd113:
            Instruction <= 32'h31ad00ff;
        9'd114:
            Instruction <= 32'hae4dfff8;
        9'd115:
            Instruction <= 32'h00000000;
        9'd116:
            Instruction <= 32'h00000000;
        9'd117:
            Instruction <= 32'h8e4c0000;
        9'd118:
            Instruction <= 32'h318c0008;
        9'd119:
            Instruction <= 32'h1580fffd;
        9'd120:
            Instruction <= 32'h314d00ff;
        9'd121:
            Instruction <= 32'hae4dfff8;
        9'd122:
            Instruction <= 32'h00000000;
        9'd123:
            Instruction <= 32'h00000000;
        9'd124:
            Instruction <= 32'h022a8820;
        9'd125:
            Instruction <= 32'h21290004;
        9'd126:
            Instruction <= 32'h08100058;
        9'd127:
            Instruction <= 32'h3232000f;
        9'd128:
            Instruction <= 32'h323300f0;
        9'd129:
            Instruction <= 32'h00139902;
        9'd130:
            Instruction <= 32'h32340f00;
        9'd131:
            Instruction <= 32'h0014a202;
        9'd132:
            Instruction <= 32'h3235f000;
        9'd133:
            Instruction <= 32'h0015ab02;
        9'd134:
            Instruction <= 32'h24090000;
        9'd135:
            Instruction <= 32'h240a030c;
        9'd136:
            Instruction <= 32'h3c0b4000;
        9'd137:
            Instruction <= 32'h216b0010;
        9'd138:
            Instruction <= 32'h2408003f;
        9'd139:
            Instruction <= 32'hac080000;
        9'd140:
            Instruction <= 32'h24080006;
        9'd141:
            Instruction <= 32'hac080004;
        9'd142:
            Instruction <= 32'h2408005b;
        9'd143:
            Instruction <= 32'hac080008;
        9'd144:
            Instruction <= 32'h2408004f;
        9'd145:
            Instruction <= 32'hac08000c;
        9'd146:
            Instruction <= 32'h24080066;
        9'd147:
            Instruction <= 32'hac080010;
        9'd148:
            Instruction <= 32'h2408006d;
        9'd149:
            Instruction <= 32'hac080014;
        9'd150:
            Instruction <= 32'h2408007d;
        9'd151:
            Instruction <= 32'hac080018;
        9'd152:
            Instruction <= 32'h24080007;
        9'd153:
            Instruction <= 32'hac08001c;
        9'd154:
            Instruction <= 32'h2408007f;
        9'd155:
            Instruction <= 32'hac080020;
        9'd156:
            Instruction <= 32'h2408006f;
        9'd157:
            Instruction <= 32'hac080024;
        9'd158:
            Instruction <= 32'h24080077;
        9'd159:
            Instruction <= 32'hac080028;
        9'd160:
            Instruction <= 32'h2408007c;
        9'd161:
            Instruction <= 32'hac08002c;
        9'd162:
            Instruction <= 32'h24080039;
        9'd163:
            Instruction <= 32'hac080030;
        9'd164:
            Instruction <= 32'h2408005e;
        9'd165:
            Instruction <= 32'hac080034;
        9'd166:
            Instruction <= 32'h24080079;
        9'd167:
            Instruction <= 32'hac080038;
        9'd168:
            Instruction <= 32'h24080071;
        9'd169:
            Instruction <= 32'hac08003c;
        9'd170:
            Instruction <= 32'h00129080;
        9'd171:
            Instruction <= 32'h00139880;
        9'd172:
            Instruction <= 32'h0014a080;
        9'd173:
            Instruction <= 32'h0015a880;
        9'd174:
            Instruction <= 32'h8e520000;
        9'd175:
            Instruction <= 32'h8e730000;
        9'd176:
            Instruction <= 32'h8e940000;
        9'd177:
            Instruction <= 32'h8eb50000;
        9'd178:
            Instruction <= 32'h22b50100;
        9'd179:
            Instruction <= 32'h22940200;
        9'd180:
            Instruction <= 32'h22730400;
        9'd181:
            Instruction <= 32'h22520800;
        9'd182:
            Instruction <= 32'h240c0000;
        9'd183:
            Instruction <= 32'h3c010001;
        9'd184:
            Instruction <= 32'h342dbf52;
        9'd185:
            Instruction <= 32'h218c0001;
        9'd186:
            Instruction <= 32'h018d082a;
        9'd187:
            Instruction <= 32'h1020005b;
        9'd188:
            Instruction <= 32'h0132082a;
        9'd189:
            Instruction <= 32'h10200003;
        9'd190:
            Instruction <= 32'had750000;
        9'd191:
            Instruction <= 32'h21290001;
        9'd192:
            Instruction <= 32'h081000bc;
        9'd193:
            Instruction <= 32'h0120082a;
        9'd194:
            Instruction <= 32'h14200003;
        9'd195:
            Instruction <= 32'had740000;
        9'd196:
            Instruction <= 32'h2129ffff;
        9'd197:
            Instruction <= 32'h081000c1;
        9'd198:
            Instruction <= 32'h012a082a;
        9'd199:
            Instruction <= 32'h10200003;
        9'd200:
            Instruction <= 32'had730000;
        9'd201:
            Instruction <= 32'h21290001;
        9'd202:
            Instruction <= 32'h081000c6;
        9'd203:
            Instruction <= 32'h0120082a;
        9'd204:
            Instruction <= 32'h1420ffec;
        9'd205:
            Instruction <= 32'had720000;
        9'd206:
            Instruction <= 32'h2129ffff;
        9'd207:
            Instruction <= 32'h081000cb;
        9'd208:
            Instruction <= 32'h08100117;
        9'd209:
            Instruction <= 32'h24141004;
        9'd210:
            Instruction <= 32'h24111084;
        9'd211:
            Instruction <= 32'hae800000;
        9'd212:
            Instruction <= 32'h24080001;
        9'd213:
            Instruction <= 32'hae280000;
        9'd214:
            Instruction <= 32'h00042080;
        9'd215:
            Instruction <= 32'h24080004;
        9'd216:
            Instruction <= 32'h0104082a;
        9'd217:
            Instruction <= 32'h10200008;
        9'd218:
            Instruction <= 32'h01144820;
        9'd219:
            Instruction <= 32'h01055020;
        9'd220:
            Instruction <= 32'h8d4a0000;
        9'd221:
            Instruction <= 32'had2a0000;
        9'd222:
            Instruction <= 32'h01115820;
        9'd223:
            Instruction <= 32'had600000;
        9'd224:
            Instruction <= 32'h21080004;
        9'd225:
            Instruction <= 32'h081000d8;
        9'd226:
            Instruction <= 32'h24080004;
        9'd227:
            Instruction <= 32'h0104082a;
        9'd228:
            Instruction <= 32'h10200031;
        9'd229:
            Instruction <= 32'h24090004;
        9'd230:
            Instruction <= 32'h2413ffff;
        9'd231:
            Instruction <= 32'h2412ffff;
        9'd232:
            Instruction <= 32'h0124082a;
        9'd233:
            Instruction <= 32'h1020000f;
        9'd234:
            Instruction <= 32'h01315020;
        9'd235:
            Instruction <= 32'h8d4a0000;
        9'd236:
            Instruction <= 32'h1540000a;
        9'd237:
            Instruction <= 32'h01345020;
        9'd238:
            Instruction <= 32'h8d4a0000;
        9'd239:
            Instruction <= 32'h240bffff;
        9'd240:
            Instruction <= 32'h114b0006;
        9'd241:
            Instruction <= 32'h126b0003;
        9'd242:
            Instruction <= 32'h0153082a;
        9'd243:
            Instruction <= 32'h14200001;
        9'd244:
            Instruction <= 32'h081000f7;
        9'd245:
            Instruction <= 32'h000a9821;
        9'd246:
            Instruction <= 32'h00099021;
        9'd247:
            Instruction <= 32'h21290004;
        9'd248:
            Instruction <= 32'h081000e8;
        9'd249:
            Instruction <= 32'h2409ffff;
        9'd250:
            Instruction <= 32'h1133001b;
        9'd251:
            Instruction <= 32'h02515020;
        9'd252:
            Instruction <= 32'h240b0001;
        9'd253:
            Instruction <= 32'had4b0000;
        9'd254:
            Instruction <= 32'h240c0004;
        9'd255:
            Instruction <= 32'h0184082a;
        9'd256:
            Instruction <= 32'h10200013;
        9'd257:
            Instruction <= 32'h01916820;
        9'd258:
            Instruction <= 32'h8dad0000;
        9'd259:
            Instruction <= 32'h15a0000e;
        9'd260:
            Instruction <= 32'h00126940;
        9'd261:
            Instruction <= 32'h01ac6820;
        9'd262:
            Instruction <= 32'h01a56820;
        9'd263:
            Instruction <= 32'h8dad0000;
        9'd264:
            Instruction <= 32'h11a90009;
        9'd265:
            Instruction <= 32'h01947020;
        9'd266:
            Instruction <= 32'h8dce0000;
        9'd267:
            Instruction <= 32'h026d7820;
        9'd268:
            Instruction <= 32'h11c90003;
        9'd269:
            Instruction <= 32'h01ee082a;
        9'd270:
            Instruction <= 32'h14200001;
        9'd271:
            Instruction <= 32'h08100112;
        9'd272:
            Instruction <= 32'h01947020;
        9'd273:
            Instruction <= 32'hadcf0000;
        9'd274:
            Instruction <= 32'h218c0004;
        9'd275:
            Instruction <= 32'h081000ff;
        9'd276:
            Instruction <= 32'h21080004;
        9'd277:
            Instruction <= 32'h081000e3;
        9'd278:
            Instruction <= 32'h03e00008;
        9'd279:
            Instruction <= 32'h08100117;


        default:
            Instruction <= 32'h00000000;
    endcase

endmodule
