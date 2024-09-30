# $t0 -> gray
# $t1 -> num
# $t2 -> bin
    .data
    .eqv val1,2
    .eqv val2,7
    .eqv val3,13
    .eqv val4,15
    .text
    .globl main

main:
    li $t0,val2
    or $t1,$t0,$0

    # num = num ^ (num>>4)
    srl $t1,$t1,4
    xor $t1,$t0,$t1

    # num = num ^ (num>>2)
    srl $t3,$t1,2
    xor $t1,$t1,$t3

    # num = num ^(num>>1)
    # bin = num
    srl $t3,$t1,1
    xor $t2,$t1,$t3

    jr $ra
