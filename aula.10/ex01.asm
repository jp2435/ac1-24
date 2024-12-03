    .data
    .eqv print_int,1
    .eqv print_float,2
    .eqv read_int,5
    .eqv read_float,6
constantes: .float 1.0
    .text
    .globl main
# função xtoy, função intermedia
xtoy:
    # $f12 -> float x
        # $f20 -> X
    # $a0 -> int y
        # $s0 -> y
    # $f22 -> result
        
    addiu $sp,$sp,-20
    sw $ra,0($sp)
    sw $s0,4($sp)
    sw $s1,8($sp)
    s.s $f20,12($sp)
    s.s $f22,16($sp)

    move $s0,$a0 # $s0 = y
    mov.s $f20,$f12 # $f20 = x

    
    li $s1,0 # i=0
    la $t1,constantes # &constantes
    l.s $f22,0($t1) # result
for:
    move $a0,$s0
    jal abs_func # abs(y)
    # $v0 = abs(y)
    bge $s1,$v0,end_xtoy
    ble $s0,$0,else # if y<=0 j else
    mul.s $f22,$f22,$f20 # result *= x
    j endif
else: div.s $f22,$f22,$f20 # result /=x
endif:  
    addiu $s1,$s1,1 # i++
    j for 

end_xtoy:
    mov.s $f0,$f22 # return result

    lw $ra,0($sp)
    lw $s0,4($sp)
    lw $s1,8($sp)
    l.s $f20,12($sp)
    l.s $f22,16($sp)
    addiu $sp,$sp,20

    jr $ra

# Função ABS, função terminal
abs_func:
    # val -> $a0
    bge $a0,$0,end_abs
    sub $a0,$0,$a0 # val=0-val=-val
end_abs:
    move $v0,$a0 # return val
    jr $ra

main: 
    addiu $sp,$sp,-4
    sw $ra,0($sp)

    li $v0,read_float
    syscall # $f0 = read_float()
    mov.s $f12,$f0

    li $v0,read_int
    syscall # $v0 = read_int()
    move $a0,$v0
    # Entradas da função
    # $f12 -> x
    # $a0 -> y
    jal xtoy

    mov.s $f12,$f0
    li $v0,print_float
    syscall



    lw $ra,0($sp)
    addiu $sp,$sp,4
    jr $ra