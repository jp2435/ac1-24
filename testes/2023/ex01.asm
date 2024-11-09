# Mapa de Registro
# $t0 -> num
# $t1 -> i
# $t2 -> order

    .data
    .eqv print_str,4
    .eqv print_int10,1
    .eqv read_int,5
str1: .asciiz "No set bits\n"
    .text
    .globl main

main:
    li $t2,-1

    li $v0,read_int
    syscall
    move $t0,$v0 # num = read_int()
    li $t1,0 # i = 0
do:
    andi $t3,$t0,1 # num & 1
    bne $t3,1,endif
    move $t2,$t1 # order = i
endif:
    srl $t0,$t0,1 # num = num>>1
    addi $t1,$t1,1 # i++
while:
    bge $t1,32,if_after_while
    j do

if_after_while:
    beq $t2,-1,else
    li $v0,print_int10
    move $a0,$t2
    syscall
    j end_prgm

else:
    li $v0,print_str
    la $a0,str1
    syscall

end_prgm:
    jr $ra