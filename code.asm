
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

    li $t6, 0x20
    beq $t5, $zero, readn
    bge $t5, $t6, readn

    sw $t5, 0($zero)    # write n to buffer
    move $s1, $t5       # set $s1 to n

    li $s2, 0 # row
    li $s3, 0 # col
    li $s4, 4 # graph

looprow:
    bge $s2, $s1, endrow
    
    sll $s6, $s2, 7 # s6 = row << 7

    li $s3, 0

loopcol:
    bge $s3, $s1, endcol

    readgraph:

        lui $t1, 0x4000
        addi $t2, $t1, 0x0020

        readgraph_1:
            lw  $t3, 0($t2)
            andi $t3, $t3, 0x00000004
            beq $t3, $zero, readgraph_1
            addi $t4, $t1, 0x001c
            lw  $t5, 0($t4)
            sll $t5, $t5, 8 # t5 = n[31:24]

        readgraph_2:
            lw  $t3, 0($t2)
            andi $t3, $t3, 0x00000004
            beq $t3, $zero, readgraph_2
            addi $t4, $t1, 0x001c
            lw  $t6, 0($t4)
            or  $t5, $t5, $t6 # t5 = n[31:16]
            sll $t5, $t5, 16

        readgraph_3:
            lw  $t3, 0($t2)
            andi $t3, $t3, 0x00000004
            beq $t3, $zero, readgraph_3
            addi $t4, $t1, 0x001c
            lw  $t6, 0($t4)
            sll $t6, $t6, 8
            or  $t5, $t5, $t6 # t5 = n[31:8]

        readgraph_4:
            lw  $t3, 0($t2)
            andi $t3, $t3, 0x00000004
            beq $t3, $zero, readgraph_4
            addi $t4, $t1, 0x001c
            lw  $t6, 0($t4)
            or  $t5, $t5, $t6 # t5 = n[31:0]
    
    sll $s7, $s3, 2 # t5 = col << 2
    add $s7, $s7, $s6 # t5 = row << 7 + col << 2
    add $s7, $s7, $s4 # t5 = row << 7 + col << 2 + graph
    sw $t5, 0($s7) # write graph to buffer

    addi $s3, $s3, 1
    j loopcol

endcol:
    addi $s2, $s2, 1
    j looprow

endrow:

main:
    li $t0, 0         # $t0 = 0(equal to buffer)

    lw   $s0, 0($t0)    # set $s0 to n
    move $a0, $s0       # set $a0 to n
    addi $a1, $t0, 4    # set $a1 to &graph

    # Call Dijkstra
    jal  dijkstra

    li  $t0, 4100
    li $t1, 0
    move $s1, $zero # result in s1
    sll $t3, $s0, 2

add_start:
    bge $t1, $t3, add_end
    add $t6, $t1, $t0
    lw $t2, 0($t6)

    lui $s2, 0x4000
    addi $s2, $s2, 0x0020

    disp1:
        lw $t4, 0($s2)
        andi $t4, $t4, 0x00000008
        bne $t4, $zero, disp1
        srl $t5, $t2, 24
        sw $t5, -8($s2)
        nop
        nop

    disp2:
        lw $t4, 0($s2)
        andi $t4, $t4, 0x00000008
        bne $t4, $zero, disp2
        srl $t5, $t2, 16
        andi $t5, $t5, 0x000000ff
        sw $t5, -8($s2)
        nop
        nop

    disp3:
        lw $t4, 0($s2)
        andi $t4, $t4, 0x00000008
        bne $t4, $zero, disp3
        srl $t5, $t2, 8
        andi $t5, $t5, 0x000000ff
        sw $t5, -8($s2)
        nop
        nop

    disp4:
        lw $t4, 0($s2)
        andi $t4, $t4, 0x00000008
        bne $t4, $zero, disp4
        andi $t5, $t2, 0x000000ff
        sw $t5, -8($s2)
        nop
        nop

    add $s1, $s1, $t2
    addi $t1, $t1, 4
    j add_start

add_end:

    andi $s2, $s1, 0x0000000f
    andi $s3, $s1, 0x000000f0
    srl $s3, $s3, 4
    andi $s4, $s1, 0x00000f00
    srl $s4, $s4, 8
    andi $s5, $s1, 0x0000f000
    srl $s5, $s5, 12

    li $t1, 0
    li $t2, 780
    lui $t3, 0x4000
    addi $t3, $t3, 0x0010

    li $t0, 63
    sw $t0, 0($zero)
    li $t0, 6
    sw $t0, 4($zero)
    li $t0, 91
    sw $t0, 8($zero)
    li $t0, 79
    sw $t0, 12($zero)
    li $t0, 102
    sw $t0, 16($zero)
    li $t0, 109
    sw $t0, 20($zero)
    li $t0, 125
    sw $t0, 24($zero)
    li $t0, 7
    sw $t0, 28($zero)
    li $t0, 127
    sw $t0, 32($zero)
    li $t0, 111
    sw $t0, 36($zero)
    li $t0, 119
    sw $t0, 40($zero)
    li $t0, 124
    sw $t0, 44($zero)
    li $t0, 57
    sw $t0, 48($zero)
    li $t0, 94
    sw $t0, 52($zero)
    li $t0, 121
    sw $t0, 56($zero)
    li $t0, 113
    sw $t0, 60($zero)

    sll $s2, $s2, 2
    sll $s3, $s3, 2
    sll $s4, $s4, 2
    sll $s5, $s5, 2

    lw $s2, 0($s2)
    lw $s3, 0($s3)
    lw $s4, 0($s4)
    lw $s5, 0($s5)

    addi $s5, $s5, 256
    addi $s4, $s4, 512
    addi $s3, $s3, 1024
    addi $s2, $s2, 2048

    li $t4, 0
    li $t5, 114514

output:
    addi $t4, $t4, 1
    bge $t4, $t5, end

out_thousand:
    bge $t1, $s2, out_hundred
    sw $s5 0($t3)
    addi $t1, $t1, 1
    j out_thousand

out_hundred:
    blt $t1, $zero, out_ten
    sw $s4 0($t3)
    addi $t1, $t1, -1
    j out_hundred

out_ten:
    bge $t1, $t2, out_one
    sw $s3 0($t3)
    addi $t1, $t1, 1
    j out_ten

out_one:
    blt $t1, $zero, output
    sw $s2 0($t3)
    addi $t1, $t1, -1
    j out_one


j end


dijkstra:
##### YOUR CODE HERE #####
    li $s4 4100 # dist[0]=0, visited[0]=1 s4 = dist
    li $s1, 4228 # s1 = visited
    sw $zero, 0($s4)
    li $t0, 1
    sw $t0, 0($s1)

    sll $a0, $a0, 2 # n*4
    li $t0, 4
for_init: # for (i = 1; i < n; i++)
    bge $t0, $a0, for_init_end

    add $t1, $t0, $s4 # dist[i] = graph[i]
    add $t2, $t0, $a1 
    lw $t2, 0($t2) 
    sw $t2, 0($t1)


    add $t3, $t0, $s1 # visited[i] = 0
    sw $zero, 0($t3)

    addi $t0, $t0, 4 # i++
    j for_init
for_init_end:

    li $t0, 4 # i = 1

for_search: # for (i = 1; i < n; i++)

    bge $t0, $a0, for_search_end

    li $t1, 4 # v = 1
    li $s3, -1 # min_dist = -1
    li $s2, -1 # u = -1

for_min_dist: # for (v = 1; v < n; v++)
    bge $t1, $a0, for_min_dist_end

    add $t2, $t1, $s1 # if (visited[v] != 0) continue
    lw $t2, 0($t2)
    bne $t2, $zero, continue_min_dist

    add $t2, $t1, $s4 # if (dist[v] == -1) continue
    lw $t2, 0($t2)
    li $t3, -1
    beq $t2, $t3, continue_min_dist

    beq $s3, $t3, if_min_dist # if (min_dist == -1)
    blt $t2, $s3, if_min_dist # if (dist[v] < min_dist)
    j continue_min_dist

if_min_dist:
    move $s3, $t2 # min_dist = dist[v]
    move $s2, $t1 # u = v

continue_min_dist:
    addi $t1, $t1, 4 # v++
    j for_min_dist

for_min_dist_end:
    li $t1, -1 # if (min_dist == -1) return
    beq $t1, $s3, for_search_end

    add $t2, $s2, $s1 # visited[u] = 1
    li $t3, 1
    sw $t3, 0($t2)

    li $t4, 4 # v = 1
for_update: # for (v = 1; v < n; v++)
    bge $t4, $a0, for_update_end

    add $t5, $t4, $s1 # if (visited[v] != 0) continue
    lw $t5, 0($t5)
    bne $t5, $zero, continue_update

    sll $t5, $s2, 5 # addr = u << 5 + v
    add $t5, $t5, $t4

    add $t5, $t5, $a1 # graph[addr]
    lw $t5, 0($t5)

    beq $t5, $t1, continue_update # if (graph[addr] == -1) continue

    add $t6, $t4, $s4 # dist[v]
    lw $t6, 0($t6)

    add $t7, $s3, $t5  # min_dist + graph[addr]

    beq $t6, $t1, if_update # if (dist[v] == -1)

    blt $t7, $t6, if_update # if (min_dist + graph[addr] < dist[v])

    j continue_update

if_update:

    add $t6, $t4, $s4 # dist[v] = min_dist + graph[addr]
    sw $t7, 0($t6)

continue_update:
    addi $t4, $t4, 4 #v++
    j for_update
for_update_end:

    addi $t0, $t0, 4 #i++
    j for_search
for_search_end:
    jr $ra

end:
j end