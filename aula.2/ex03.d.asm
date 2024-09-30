# $t0 -> a
# $t1 -> b
    .data
    .eqv print_string,4
    .eqv print_int10,1
    .eqv read_int,5
str1: .asciiz "Introduza 2 numeros"
str2: .asciiz "A soma dos dois numeros: "
    .text
    .globl main

main:
    la $a0,str1
    ori $v0,$0,print_string
    syscall # Texto de introducao de valores

    ori $v0,$0,read_int
    syscall # read_int()
    or $t0,$v0,$0 # $t0 = $v0 (Valor introduzido)

    ori $v0,$0,read_int
    syscall # read_int()
    or $t1,$v0,$0 # $t1 = $v0

    la $a0,str2
    ori $v0,$0,print_string
    syscall # Texto final

    add $t2,$t0,$t1 # a+b
    or $a0,$t2,$0
    # add $a0,$t0,$t1

    ori $v0,$0,print_int10
    syscall

    jr $ra