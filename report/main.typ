#import "../template.typ": *

// #set par(first-line-indent: 2em, hanging-indent: 10pt, justify: true)
#show: project.with(
  title: "《数字逻辑与处理器基础》课程大作业报告"
)

= 实验目的
#v(0.5em)
+ 通过使用 Verilog 完成一个五级 MIPS 流水线，巩固理论课所学知识；综合运用前四次小作业中学到的知识，提高 Verilog 的编写能力和 Debug 能力；#v(5pt)
+ 连接流水线与外设，体会总线与外设对 CPU 的扩展性起到的好处；#v(5pt)
+ 完成流水线后通过软件方式进行译码等操作，与前几次小作业中的硬件方式操作相对比，体会软件方式和硬件方式之间的不同之处；#v(5pt)
+ 巩固时序静态分析、资源占用情况分析的能力；

= 设计方案
#v(0.5em)
#h(2em)本次实验中，我的流水线设计方案综合了理论课上的设计和参考书#footnote[[美]David A.Patterson，[美]John L. Hennessy：《计算机组成与设计——软件硬件接口》，王党辉等译，机械工业出版社，北京，2015 年。]上的数据通路，添加了连接外设的数据通路，并根据实际需要做了一定的修改。此外，我还实现了数码管交替显示输出、通过串口与计算机进行输入输出通信的功能。
== 总体设计
#v(0.5em)
#h(2em)流水线 CPU 共分为 5 个流水阶段，分别为 IF、ID、EX、MEM、WB。流水线在 ID 阶段进行跳转，在 EX 阶段进行分支。此外，为了解决冒险问题，还加入了转发单元 Forward Unit 用于解决数据冒险、冒险单元 Hazard Unit 用于解决 Load-Use 型数据冒险和分支、跳转指令引起的控制冒险。外设部分，LED 用于在数码管上显示、UART 用于与计算机之间通信。

== 控制信号生成
#v(0.5em)
#h(2em)为了最大化复用单周期的代码，我将单周期的控制信号原封不动地搬了过来；同时，为了支持要求中的多种分支指令，以及我自己添加的 `bne` 指令，我额外加入了 `BranchType` 控制信号。最终，形成了如附录中@control 的控制信号真值表。

== Hazard Unit 设计方案
#v(0.5em)
- 对于 Load-Use 冒险，采取在 ID 阶段检出 Load-Use 冒险后 Keep PC、Keep IF/ID、Flush ID/EX 的策略；#v(5pt)
- 对于 branch 引发的冒险，采取静态分支预测的方法，在 ID 阶段检出 branch 指令后不做任何操作，在 EX 阶段若检出跳转执行，则 branch PC、Flush IF/ID、Flush ID/EX；#v(5pt)
- 对于 J 引发的冒险，在 ID 阶段检出跳转后 jump PC、Flush IF/ID。

== Forward Unit 设计方案
#v(0.5em)
#h(2em)为了尽可能复用代码，我将对 ALU 输入的转发统一封装成了 Forward Unit。判断逻辑有如下伪代码：

```cpp

if (EX/MEM.RegWrite && (EX/MEM.RegWrAddr != 0) && (EX/MEM.RegWrAddr == ID/EXRegister))
    forward = 10;
else if ((MEM/WB.RegWrite && (MEM/WB.RegWrAddr != 0) && (MEM/WB.RegWrAddr == ID/EXRegister))
    forward = 01;
else
    forward = 00;
```

#h(2em)但需要注意，这样的转发逻辑遗漏了 `sw` 部分的转发，而教材上的数据通路同样遗漏了这一转发，这使得 `sw` 的内容依赖前一条指令的计算结果时会出错，因此，经过 EX/MEM 中间寄存器写入内存的 `writeData` 同样需要被转发，转发逻辑同上。

== 连接外设
#v(0.5em)
#h(2em)在 MEM 阶段访存时进行判断：如果地址的高四位为 `0x4`，则关闭内存的 `memWrite` 和 `memRead`，同时将要地址与要写入内存的值传到总线上，再将内存读出的值修改为外设输入的值。然后，将 CPU 输出的各个信号连接到 LED 和 UART 上、将 UART 的输出（LED 无输出）连接到 CPU 的输入即可。

== LED 的设计
#v(0.5em)
#h(2em)由于本次实验要求用软件译码，LED 的实现没有什么难度，只需要在检测到地址为 `0x40000010` 时，将 CPU 写入的值直接转发到板上对应的 LED 和 ANO 接口上即可。
 
== UART 的设计
#v(0.5em)
#h(2em)UART 内部使用 RX 和 TX 两个小模块，直接使用小作业中的代码即可。由于串口每次只能收发 8bit 的数据，且串口的频率远低于 CPU，因此在设计汇编时，需要注意添加适当的等待，且需要对读入的数据做移位的转换。

== 总体设计
#v(0.5em)
#h(2em)经过上面各个模块的内部设计及冒险解决的设计，最终形成了总体的设计图如@totalfig 所示。

= 关键代码及文件清单

== 文件清单
#v(0.5em)
- `ALU.v`：控制 ALU 模块，复用自单周期代码，相比之下增加了几种新的分支指令的支持；
- `ALUControl.v`：给 ALU 模块生成控制信号，完全复用自单周期代码，无改动；
- `code.asm`：最终使用的汇编代码，使用测试代码为 `Dijkstra` 算法，支持串口输入、串口输出、LED 输出；
- `Control.v`：生成控制信号，与单周期相比增加了几种新的分支指令的支持；
- `CPU.v`：流水线的主体部分，将内部各个模块组合在一起；
- `DataMemory.v`：内存模块，由于消耗资源太大（需要 4356 Byte 的内存），因此放弃了单周期中使用寄存器的写法，转而使用 BRAM 的 IP 核；
- `ForwardUnit.v`：转发模块，用于解决数据冒险；
- `generate_test_case.cc`：用于生成测试样例，分别会生成 `test.dat` 用于在 C++ 算法中做测试、以及 `test2.txt`，用于后续测试的处理；
- `Hazard.v`：冒险检测单元，用于解决控制冒险；
- `instruction_convert.py`：将 MARS 生成的十六进制串转为适合写入 `InstructionMemory` 的形式；
- `InstructionMemory.v`：指令存储器，内部指令翻译自 `code.asm`；
- `LED.v`：用于将内存写入的地址转发到数码管上，以便显示；
- `RegBetween.v`：级间寄存器，用于在不同的流水阶段之间传递数据；
- `RegisterFile.v`：寄存器堆，直接复用自单周期代码；
- `testCPU.v`：仿真使用的测试代码，实例化了 cpu、led、uart，同时现有代码中提供了一组用于串口仿真的代码。为了节省仿真时间，此处需要将串口改为 10 clks per bit（波特率直接百倍增加了，只适用于仿真）；
- `top.v`：最终的顶层代码，实例化了 cpu、led 和 uart，同时使用了 IP 核的锁相环来分频；
- `top.xdc`：使用的约束文件，此处由于使用了锁相环，IP 核为我们自动添加了时钟约束，因此不需要另写时钟约束；
- `uart_generate.py`：基于前面生成的 `test2.txt` 生成 `hex.txt` 和 `out.txt`，前者用于上板后输入到串口中，后者用于在仿真时模拟串口输入；
- `uart_rx.v`：串口接收部分，直接复用自小作业；
- `uart_tx.v`：串口发送部分，直接服用自小作业；
- `UART.v`：串口部分顶层模块，用于实现串口功能。

== 关键代码
#v(0.5em)
#h(2em)此处列举了部分关键代码，这些代码或在开发、调试流水线的过程中起到了极大的便利性，或经过了巧妙的设计，使我认为有必要在此处一一列举。

=== 级间寄存器的复用
```v

module RegBetween
    #(parameter SIZE=32)
    
```
使用可变参数的级间寄存器，从而极大地加强了级间寄存器的复用性

=== 级间寄存器的刷写
```v

always @(posedge clk or posedge rst)
    if (rst)
        dataOut <= 0;
    else if (flush == 2'b00) // no flush
        dataOut <= dataIn;
    else if (flush == 2'b01) // flush
        dataOut <= 0;
    else if (flush == 2'b10) // keep
        dataOut <= dataOut;
    else
        dataOut <= 0;
    
```
使用信号控制级间寄存器的刷写，从而解决了 Load-Use 型数据冒险与分支、跳转引起的控制冒险。

=== 寄存器堆的先写后读
```v

assign Read_data1 = (Read_register1 == 5'b00000)? 32'h00000000: (Write_register != 0 && RegWrite && (Write_register == Read_register1))? Write_data: RF_data[Read_register1];
assign Read_data2 = (Read_register2 == 5'b00000)? 32'h00000000: (Write_register != 0 && RegWrite && (Write_register == Read_register2))? Write_data:RF_data[Read_register2];
    
```
通过直接转发，实现了寄存器堆的先写后读，无须再解决 WB -> ID 的冒险。

=== 指令翻译
```python

with open("default.txt", "r") as f: # here default.txt includes the machine code
    lines = f.readlines()

with open("convert.txt", "w") as f:
    i = 0
    for line in lines:
        f.write(f"9'd{i}: Instruction <= 32'h" + line.replace("\n", "") + ";\n")
        i += 1

```
使用 python 对 MARS 生成的机器码做了二次处理，从而大幅提高了仿真 Debug 效率。

=== 转发单元
```v

assign forward = ((EXMEMWrite == 1) && (EXMEMAddr != 0) && (EXMEMAddr == target))?2'b10:((MEMWBWrite == 1) && (MEMWBAddr != 0) && (MEMWBAddr == target))?2'b01:2'b00;

assign aluSrcA = (ALUSrc1_EX)? {27'h00000, shamt}: readData1_EX;
assign aluInputA = (forwardCtlA==2'b00 || ALUSrc1_EX)?aluSrcA:(forwardCtlA==2'b01)?writeData:(forwardCtlA == 2'b10)?ALUResult_MEM:0;

```
通过转发单元解决了各类数据冒险问题。

=== 冒险单元
```v

assign PCFlush = ((IDEXRt == IFIDRs || IDEXRt == IFIDRt) && memRead)? 2'b10: 2'b00;
assign IFIDFlush = ((IDEXRt == IFIDRs || IDEXRt == IFIDRt) && memRead)? 2'b10: (PCSrcID == 2'b01 || PCSrcID == 2'b10 || (zero && branch_EX))? 2'b01: 2'b00;
assign IDEXFlush = ((zero && branch_EX) || ((IDEXRt == IFIDRs || IDEXRt == IFIDRt) && memRead))? 2'b01: 2'b00;

```
通过生成控制冒险信号与级间寄存器的配合，解决了控制冒险问题。

=== 连接外设
```v

assign readMemData = (ALUResult_MEM[31:28] == 4'h4)? deviceData: memData;
assign memAddr = (ALUResult_MEM[31:28] == 4'h4)? ALUResult_MEM : 0;
assign memDat = (ALUResult_MEM[31:28] == 4'h4)? readData2_MEM : 0;
// here memAddr and memDat are output to Device

```
通过按照地址检测判断来连接外设。

=== BCD 译码的汇编实现
```yasm

li $t0, 63
sw $t0, 0($zero)
li $t0, 6
sw $t0, 4($zero)
li $t0, 91
sw $t0, 8($zero)
li $t0, 79
sw $t0, 12($zero)
# others are duplicated
li $t0, 113
sw $t0, 60($zero)

sll $s2, $s2, 2 # s2 stores a 4-bit number
lw $s2, 0($s2)

```
通过巧妙的内存地址映射，避免了 BCD 译码漫长的 if-else 打表过程。#footnote[根据室友的实际体会可知，自己手动用 if-else 打表大概要两三百行才能译码，此处只用了 40 行代码就成功译码，不可谓没有大幅降低重复工作成本。此外，根据使用 #link("https://godbolt.org") 汇编可知，其实也可以通过地址打表的方式，实现类似 C 中 `case` 的效果，但是终究不如我的代码来得巧妙、行数来得少，不再赘述。]

=== UART 的读取
```yasm

readn:
    lui $t1, 0x4000
    addi $t2, $t1, 0x0020
readn_1:
    lw  $t3, 0($t2)
    andi $t3, $t3, 0x00000004
    beq $t3, $zero, readn_1
    addi $t4, $t1, 0x001c
    lw  $t5, 0($t4)
    sll $t5, $t5, 8 # t5 = n[31:24]
readn_2:
    lw  $t3, 0($t2)
    andi $t3, $t3, 0x00000004
    beq $t3, $zero, readn_2
    addi $t4, $t1, 0x001c
    lw  $t6, 0($t4)
    or  $t5, $t5, $t6 # t5 = n[31:16]
    sll $t5, $t5, 16
readn_3:
    lw  $t3, 0($t2)
    andi $t3, $t3, 0x00000004
    beq $t3, $zero, readn_3
    addi $t4, $t1, 0x001c
    lw  $t6, 0($t4)
    sll $t6, $t6, 8
    or  $t5, $t5, $t6 # t5 = n[31:8]
readn_4:
    lw  $t3, 0($t2)
    andi $t3, $t3, 0x00000004
    beq $t3, $zero, readn_4
    addi $t4, $t1, 0x001c
    lw  $t6, 0($t4)
    or  $t5, $t5, $t6 # t5 = n[31:0]

```
利用忙等待 + 循环的方法，解决了 CPU 和 UART 串口之间通信速率相差巨大的问题（9600 波特率与 80+MHz 频率，二者相差上百倍），连续读取了四个 Byte，没有在串口端产生过多的额外资源消耗。此外，写串口也采用了类似的忙等待方法。

=== 生成测试样例
```cpp

std::uniform_int_distribution<int> distrib(1, 200);  // 随机数范围，也可以改分布情况
cin >> n;  // 输入点数
for (int i = 0; i < n; i++)
    for (int j = 0; j < i; j++)
    {
        if (i == j)
            continue;
        graph[i * 32 + j] = unsigned(distrib(gen));
        if (graph[i * 32 + j] < 60 && graph[i * 32 + j] > 40)  // 用于调整删掉多少边
            graph[i * 32 + j] = -1;
        graph[j * 32 + i] = graph[i * 32 + j];
    }

```

生成了不同规模、不同分布的测试样例，从而有利于对流水线工作的正确性做全面测试。

=== 仿真/上板串口样例处理
```py

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

```
利用 Python 脚本，分别基于前面的样例生成了用于仿真的输入和用于输入到串口中的输入，有效避免了重复的机械性劳动。
= 仿真结果及分析

== 输入数据集准备
#v(0.5em)
#h(2em)我们利用前面提到的 C++ 代码随机生成一组 32 个测试样例点的数据（这也是我的 CPU 支持的上限）。各边长度分布从 $1 ~9$ 不等，且有超过一半的概率为 -1，这能够比较好地体现出我们 CPU 的性能。具体的测试用图如@Graph 所示，这张图上的单源最短路结果如@Result 所示。

#figure(caption: "测试样例", image("Graph.png", width: 60%), supplement: "图")<Graph>
#figure(caption: "对应答案", image("Result.png", width: 60%), supplement: "图")<Result>

== 仿真验证正确性
#v(0.5em)
#h(2em)我们采用前面提到的 Python 脚本将这 1025 个数据用串口仿真的形式发送到 CPU 上。如果计算结果正确，LED 上应该显示为 `006b`。经过一段时间的仿真，可以看到这个结果是正确的，如@Sim 所示。

#figure(caption: "仿真波形", image("Sim.png", width: 90%), supplement: "图")<Sim>

#h(2em)此处各个位的持续时间不等长的原因，是因为我的循环显示部分是采取从 0 加上去到某一个数，然后再减下来的做法。由于 `blt` 和 `bge` 编译出来的指令数相差 1，因此持续时间也会发生对应的变化。对于实际效果，则没有明显影响。

== CPI 计算
#v(0.5em)
#h(2em)通过 MARS 运行原始理论课汇编大作业上的代码，发现结果如@MARS 所示。可以看到指令数是非常庞大的，因此 `syscall` 被替换等误差均可被忽略。

#figure(caption: "指令数", image("MARS.png", width: 60%), supplement: "图")<MARS>

#h(2em)根据汇编代码可知，从结束使用 RX 串口到开始使用 TX 串口这一段时间，可近似为 CPU 上执行 Dijkstra 算法的总运行时间，头尾的几条加减法指令均可以在庞大的总指令数面前被忽略掉。在仿真波形上，我们容易观察到这段时间，如@CLOCK 所示。
#figure(caption: "运行时间", image("Clocks.png", width: 60%), supplement: "图")<CLOCK>
那么可以计算出，总时钟数（仿真采用周期为 10ns 的时钟）约为$ (4398655-4100004)/(10)approx 29865 $
从而易知$ "CPI"=29865/22304=1.339 $
值得注意的是，此处的 CPI 严格依赖于测试使用的数据。由于我采取静态分支预测不跳转的策略来进行分支处理，因此遇到大规模跳转的情况下，CPI 将会有所上升。例如，我们这里采用了一个 $32times 32$ 的图，而我们给定的长度的下限为 1，上限为 9。也就是说，我们遇到分支跳转的频率会非常高，此时性能就会收比较严重的影响。根据不同的测试样例，这个 CPI 在 1.28 到 1.34 之间上下浮动。例如，在实验室线下验收时，我用一个相对比较小的图（10 个点）跑出了 1.29 的 CPI。如果分支进一步减少，那么 CPI 还可以降低。在更小的测试样例上，我也跑出过 1.28 左右的 CPI。因此，此处的 CPI 只能大致确定一个量级，具体 CPI 的上下浮动是意义不大的。

= 综合情况

== 资源占用
#v(0.5em)
#h(2em)如@Resource 所示，由于使用了 IP 核技术，因此 LUT 占用和 FF 占用大规模降低，取而代之的是 BRAM 和锁相环的占用。此处同样贴上单周期的资源占用供对比参考。可以看出，LUT 和寄存器都有所减少。但实际上，只看内存部分以外的 LUT 和寄存器使用是有所增加的：以寄存器为例，单周期只有 $8425-8192=233$ 个，而流水线却占用了 $1467$ 个，这主要是因为流水线存在级间寄存器，这大量消耗了资源。

#figure(caption: "流水线资源占用", image("Resource.png", width: 90%), supplement: "图")<Resource>

#figure(caption: "单周期资源占用", image("Single.png", width: 90%), supplement: "图")<Single>

== 静态时序分析
#v(0.5em)
#h(2em)由于转发路径判断逻辑复杂、电路规模庞大、Net Delay 极高等原因，我的电路起初主频很低，只有约 70MHz。经过了一定的优化尝试，我发现除非大规模修改转发路径，否则很难再进一步优化主频。经过一番查阅资料，我发现，由于 Vivado 在实现一级上有更多的优化方案，因此存在综合不满足时序约束、但实现满足时序约束的情况。同时，我和往届学长#footnote[此处参考了无 06 班刘浩然学长在优化主频上采取的方法，即不断试探着去设置更严格的时序约束]进行了一定的交流，了解到可以通过设置更严格的时序约束，去“逼迫”Vivado 采用更激进的优化策略，如打破层级化设计等，来优化主频。经过这样一番尝试，我发现果然可行。最终，我发现在将锁相环分出的时钟调整至 84.5MHz 时，虽然综合部分没有满足时序约束（@synth），但是实现部分却满足了时序约束（@impl）。因此，在现有的主频下，我的设计上板后是可以满足时序约束的。

#figure(caption: "综合时序约束", image("synth.png", width: 90%), supplement: "图")<synth>

#figure(caption: "实现时序约束", image("impl.png", width: 90%), supplement: "图")<impl>

#h(2em)需要注意，锁相环只能生成 84.44MHz 的时钟，不能生成恰好的85MHz。最终频率为 $ 1/(1/(84.44 times 10^6)-0.041 times 10^(-9))=84.73 "MHz" $

= 硬件调试情况
#v(0.5em)
#h(2em)我们额外生成一组测试数据（之前的数据过小，不够具有代表性）进行测试。选用的测试数据及其结果如 @Graph1、@Result1 所示：

#figure(caption: "新测试样例", image("Graph1.png", width: 60%), supplement: "图")<Graph1>
#figure(caption: "新对应答案", image("Result1.png", width: 60%), supplement: "图")<Result1>

#h(2em)将其通过串口发送到板子上，发现板子上的 LED 正确显示了结果（0x218C），同时串口也正确发回了第 0 个点到各个点的距离，如@Board#footnote[此处由于拍摄环境较暗，手机自动曝光效果较差，因此使用了较快的快门速度拍摄。]、@Serial 所示。

#figure(caption: "LED 显示情况", image("Board.jpg", width: 60%), supplement: "图")<Board>
#figure(caption: "串口发回数据", image("Serial.png", width: 60%), supplement: "图")<Serial>

= 心得体会

#v(0.5em)
#h(2em)本次大作业约消耗了我 25 小时的时间。其中前 5 小时我对照理论课 PPT 完成了一个简易的流水线（不连接任何外设），接下来 10 小时都是在对简易流水线进行痛苦的仿真 Debug，随后 1 小时将流水线连接到了 LED 上，接下来 5 小时将流水线连接到了串口上，最后 4 小时进行各类测试、小幅优化工作。在这一过程中，我有了不少的体会，此处一一列出。

== 前期设计的重要性
#v(0.5em)
#h(2em)关于顶层设计部分，我最初是以数逻理论课 PPT 的流水线设计为主要参考对象，进行了初版的设计；这带来了一些问题：PPT 上的部分设计和我的设计是不符合的（例如 PPT 上没有出现过在 EX 阶段分支的电路图），我在编写代码时在这部分就直接“脑内设计电路”编写，最终不出所料地出现了错误，这浪费了我大量的 Debug 时间；甚至 PPT 上的电路图还存在错误（PPT 的电路图没有考虑 `sw` 指令的数据冒险问题），在最初我是没有意识到这一点的，直到最后逐条指令 Debug 时才发现这个问题。也就是说，这种“设计不完善就开始写代码”的问题，给我的 Debug 造成了巨大困扰。

#h(2em)除此之外，有部分细分模块的设计，我其实也是没有想好就开始做了。例如，我们在数逻理论课上总说“寄存器堆的先写后读”，这到底是怎么实现的？在写代码时我其实没有想过这个问题，只是想着“自然地写出来就一定支持吧！”就直接复用了单周期的代码。然而，这个显然是不能自动实现的，最终这个 Bug 依然是在后期 Debug 的时候才被发现修复了。

#h(2em)总的来说，可以看到，一个清晰的前期设计，可以极大程度减少 Debug 过程中浪费的精力。

== 中期 Debug 中的种种困难
#v(0.5em)
#h(2em)通过仿真来调试代码，看起来和正常编程语言的调试没什么本质区别，可实际写起来才发现，这一过程是有本质差异的。例如，正常编程语言调试中可以方便地设置条件断点等一系列方便调试的方法，而 Vivado 仿真就没法做到这些，这给仿真带来了极大的困难。因此，最后我只能把 PC 的波形、各个寄存器的波形、部分关键内存的波形和各种关键控制信号的波形全部拖出来画出来，仿一段时间后去找我们关注的部分，这是极为浪费时间的。不幸中的万幸，是我的代码完全由自己手动编写，因此整个流程中，我对各个信号都应该是什么是极度清楚的，因此还存在 Debug。如果有部分参考“版本”且没有完全理解的话，那出现了 BUG 就完全无法解决了。

== 切忌想当然
#v(0.5em)
#h(2em)在通过串口从计算机向 CPU 发送数据时，我遇到了奇怪的现象：仿真没有任何问题，但是上板怎么也跑不出来正确结果，只有发送的第一个数据能被正常读取。经过反复尝试，我定位到了问题：我发送的数据大概格式为 `"num1\n num2\n num3\n..."`，而这个回车导致了问题所在（向串口发送了错误的冗余数据）。经过一番 Debug（大概浪费了 3 个小时才发现这个问题），问题得到了解决（改用 `"num1 num2 num3..."`这样的格式发送）。这说明，调试过程要多注意细节，切忌想当然。

== 软硬件结合解决问题
#v(0.5em)
#h(2em)在调试 UART 的部分时，我发现，由于我的设计特点，UART 向计算机发送数据是额外需要两个周期来更新状态的。这就导致，如果我前一个时钟写入要写的数据（`0x40000018`），后一到两个周期去读 UART 是否可以发送的状态（`0x40000020`），那读出来的数据就会出现没有及时更新的问题。为此，我选择在写入一个 Byte 之后插入两个 `nop` 再继续操作，这就通过软件硬件相结合来解决了这一问题。

#h(2em)此外，在将大面积寄存器换为 BRAM 时，我遇到了 BRAM 读取有延时的问题（当前周期读出的是上一周期的地址中的内容），为此，我通过汇编优化的方式，做到每次 `lw` 都保证偏移量为 0，且加载的地址是前一条指令刚刚算出来的，这样就确保了连续两个周期输入到内存中的地址不会发生改变，从而避免了这一问题。

== Vivado 的 BUG
#v(0.5em)
#h(2em)我自己并没有遇到 Vivado 的任何 BUG，但是由于我的大作业完成时间比较早，因此我实际上给几位比较熟悉的同学的开发过程提供了一定的建议。其中，我发现他们有很多人都遇到了 Vivado 的各种 BUG，即仿真波形正确、无 Critical Warning，但是上板结果不对。有的同学使用了一些玄学方法来解决，例如更新 Vivado 版本到 2023.1、在所有涉及冒险的指令后加入 `nop` （但实际上仿真是不需要这样 `nop` 的）等。可见，硬件调试和软件不同，还是要一点玄学和运气的。

== 总结
#v(0.5em)
#h(2em)本次实验综合运用了前四次小实验中我所掌握的所有知识，没有前四次实验累积下来的经验，我是不可能在最终的大作业中完成流水线的。本学期的数逻实验课让我学习到了如何编写 Verilog、如何对实际 FPGA 上的硬件电路进行调试等诸多技能，也是对我数逻理论课所学知识的一个总结。最后，感谢孙忆南老师、孙智老师及各位助教在本学期的指导！

#pagebreak()

#set heading(numbering: none)

= 附录

== 控制信号真值表

#figure(caption: "控制信号", image("控制信号.png", height: 90%), supplement: "图", )<control>

== 流水线-外设示意图

#figure(caption: "数据通路示意图", image("大作业数据通路.jpg"), supplement: "图", )<totalfig>