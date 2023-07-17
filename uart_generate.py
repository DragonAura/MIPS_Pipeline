with open("test2.txt", "r") as f:
    lines = f.readlines()
    lines = [line.replace("\n", "") for line in lines]
    lines = [line.replace(" ", "") for line in lines]

# i = 0

with open("out.txt", "w") as f:
    for line in lines:
        num = int(line)
        if num == -1:
            num = 10
        f.write(
            f"for (i = 3; i >= 0; i = i - 1) begin\n#100 rx = 0;\nfor (j = 0; j < 8; j = j + 1) begin\n#100 rx = data{num}[8 * i + j];\nend\n#100 rx = 1;\nend\n"
        )

with open("hex.txt", "w") as f:
    for line in lines:
        if len(line) < 8:
            line = "0" * (8 - len(line)) + line
        f.write(line + " ")
