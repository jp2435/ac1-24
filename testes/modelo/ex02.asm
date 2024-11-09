#
# $t0 -> i
# $t1 -> val
# $t2 -> v
    .data
    .eqv SIZE,8
    .eqv print_int10,1
    .eqv print_str,4
    .eqv print_char,11
val: .word 8,4,15,-1987,327,-9,27,16
str1: .asciiz "Result is:"
    .text
    .globl main

main:
    la $t1,val
    li $t0,0# i=0
    li $t5,SIZE
    srl $t5,$t5,1 # SIZE/2

do:
    sll $t3,$t0,2 # i*4
    addu $t4,$t1,$t3 # &val[i]
    lw $t2,0($t4) # v = val[i]

    srl $t6,$t5,1 # SIZE/2
    add $t6,$t6,$t0 # i+SIZE/2
    sll $t6,$t6,2 # (i+SIZE/2)*4
    addu $t7,$t1,$t6 # &val[i+SIZE/2]
    lw $t6,0($t7) # val[i+SIZE/2] Valor
    sw $t6,0($t4) # val[i] = val[i+SIZE/2]
    
    sw $t2,0($t7) # val[i+SIZE/2] = v
while:
    addi $t0,$t0,1 # ++i
    srl $t6,$t5,1 # SIZE/2
    bge $t0,$t6,endw
    j do
endw:
    li $v0,print_str
    la $a0,str1
    syscall

    li $t0,0 # i= 0
do2:
    sll $t3,$t0,2 # i*4
    addu $t4,$t1,$t3 # &val[i]
    lw $t4,0($t4) # val[i]
    addi $t0,$t0,1 # i++
    li $v0,print_int10
    move $a0,$t4
    syscall
    li $v0,print_char
    li $a0,','
    syscall
while2:
    bge $t0,$t5,endprgm
    j do2
endprgm:
    jr $ra