# Mapa de registos
# $t0 -> n
# $t1 -> val
# $t2 -> min
# $t3 -> max
    .data
    .eqv print_int10,1
    .eqv print_str,4
    .eqv read_int,5
    .eqv print_char,11
str1: .asciiz "Digite ate 20 inteiros (Zero pra terminar):"
str2: .asciiz "Maximo/Minimo sao: "
    .text
    .globl main
main:
    li $t0,0 # n=0
    li $t2,0x7fffffff # min = 0x7f..ff
    li $t3,0x80000000 # max = 0x80..00
    li $v0,print_str
    la $a0,str1
    syscall
do:
    li  $v0,read_int
    syscall
    move $t1,$v0 # val = read_int()
    # if_label
    beq $t1,$0,endif # val = 0 salta pra o endif
    
    # if2_label
    ble $t1,$t3,if3
    move $t3,$t1 # max = val
if3:
    bge $t1,$t2,endif
    move $t2,$t1 # min = val

endif:
    addi $t0,$t0,1 # n++

while:
    bge $t0,20,endprgm
    beq $t1,0,endprgm
    j do

endprgm:
    li $v0,print_str
    la $a0,str2
    syscall
    li $v0,print_int10
    move $a0,$t3
    syscall # print_int10(max)
    li $v0,print_char
    li $a0,';'
    syscall
    li $v0,print_int10
    move $a0,$t2
    syscall # print_int10(min)
    jr $ra