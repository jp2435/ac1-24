    .data
    .eqv print_double,3
    .eqv read_double,7
constantes: .double 0.0,0.5,1.0
    .text
    .globl main
sqrt:
    # $f12 -> val
        # $f0 -> val
    # $f2 -> xn
    # $f4 -> aux
    # $f6 -> 0.0
    mov.d $f0,$f12
    la $t0,constantes
    l.d $f6,0($t0)
    l.d $f2,16($t0) # xn = 1.0
    li $t1,1 # i=0
    # if_label
    c.le.d $f0,$f6
    # Caso val seja menor ou igual a zero j else
    bc1t else
do:
    mov.d $f4,$f2 # aux=xn
    div.d $f8,$f0,$f2 # temp1=val/xn
    add.d $f10,$f2,$f8 # temp2=(xn+temp1)
    l.d $f8,8($t0) # temp3=0.5
    mul.d $f2,$f8,$f10 # xn=0.5*temp2
while:
    c.eq.d $f4,$f2
    bc1t end_sqrt
    addiu $t1,$t1,1 # ++i
    bge $t1,25,end_sqrt
    j do
else:
    l.d $f2,0($t0) # xn=0.0
end_sqrt:
    mov.d $f0,$f2 # return xn
    jr $ra

main: 
    addiu $sp,$sp,-4
    sw $ra,0($sp)

    li $v0,read_double
    syscall
    mov.d $f12,$f0

    jal sqrt
    mov.d $f12,$f0

    li $v0,print_double
    syscall

    lw $ra,0($sp)
    addiu $sp,$sp,4
    
    jr $ra