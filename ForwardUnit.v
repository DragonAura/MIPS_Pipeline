module ForwardUnit(
        input [4:0] EXMEMAddr,
        input [4:0] MEMWBAddr,
        input [4:0] target,
        input EXMEMWrite,
        input MEMWBWrite,
        output [1:0] forward
    );

    assign forward = ((EXMEMWrite == 1) && (EXMEMAddr != 0) && (EXMEMAddr == target))?2'b10:((MEMWBWrite == 1) && (MEMWBAddr != 0) && (MEMWBAddr == target))?2'b01:2'b00;

endmodule
