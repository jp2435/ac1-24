    .data
str1: .asciiz "String qualquer"
str2: .asciiz "AC1-P"
    .eqv print_string,4
    .text
    .globl main
main:
    la $a0,str2 # $a0 -> paramentro da funçao
    ori $v0,$0,print_string # $v0->4 funçao
    syscall
    jr $ra