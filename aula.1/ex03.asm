    .data
    .eqv read_int,5
    .eqv print_int,1
    .eqv print_int16,34
    .eqv print_intu10,36
    .text
    .globl main

main:
    ori $v0,$0,read_int # systemcall read_int() código 5

    syscall
    or $t0,$0,$v0 # retirar o input de $v0 pra $t0

    ori $t2,$0,8
    add $t1,$t0,$t0
    sub $t1,$t1,$t2

    or $a0,$0,$t1
    ori $v0,$0,print_intu10 # syscall print_int() código 1
    syscall
    jr $ra
