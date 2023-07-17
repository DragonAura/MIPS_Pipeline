with open("default.txt", "r") as f:
    lines = f.readlines()

with open("convert.txt", "w") as f:
    i = 0
    for line in lines:
        f.write(f"9'd{i}: Instruction <= 32'h" + line.replace("\n", "") + ";\n")
        i += 1
