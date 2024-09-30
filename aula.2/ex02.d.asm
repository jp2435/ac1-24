    .data
    .eqv val1,2 # 4 e 5
    .text
    .globl main

main:
    li $t0,val1 # bin
    srl $t1,$t0,1 # bin>>1
    xor $t1,$t0,$t1 # bin ^ bin>>1

    jr $ra
