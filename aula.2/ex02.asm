#
# 0x12345678,1
# 0x12345678,4
# 0x12345678,16
# 0x862a5c1b,2
# 0x862a5c1b,4
    .data
    .eqv val1,0x12345678
    .eqv val2,0x862a5c1b
    .eqv imm,4
    .text
    .globl main
main:
    li $t0,val2

    sll $t2,$t0,imm
    srl $t3,$t0,imm
    sra $t4,$t0,imm
    jr $ra
