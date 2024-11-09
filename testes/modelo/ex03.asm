# Mapa de registos 
# n_even: $t0
# n_odd: $t1
# p1: $t2
# p2: $t3
# ********************************************
    .data
    .eqv N,35 # N*4=35*4bytes=140
a_array: .space 140
b_array: .space 140
    .text
    .globl main
main:
    li $t0,0 # n_even = 0
    li $t1,0 # n_odd = 0
    la $t2,a_array # p1 = a
    la $t3,b_array # p2 = b
    li $t4,N
    sll $t4,$t4,2 # N*4
    addu $t4,$t2,$t4 # (a+N)
for:
    bge $t2,$t4,endfor
    li $v0,5 # read_int()
    syscall
    sw $v0,0($t2) # *p1 = read_int()
    addiu $t2,$t2,4 # p1++
    j for
    
endfor:
    la $t2,a_array # p1 = a
    la $t3,b_array # p2 = b    
    #li $t4,N
    #addu $t4,$t2,$t4 # (a+N)
for2:
    bge $t2,$t4,endfor2
    # if_label
    lw $t5,0($t2) # *p1
    andi $t6,$t5,1 # *p1%2
    beq $t6,0,else
    sw $t5,0($t3) # *p2 = *p1
    addi $t1,$t1,1 # n_odd++
    addiu $t3,$t3,4 # p2++
    j endif
    
else:
    addi $t0,$t0,1 # n_even++
endif:
    addiu $t2,$t2,4 # p1++
    j for2
    
endfor2:
    la $t3,b_array # p2 = b
    sll $t5,$t1,2 # n_odd*4
    addu $t5,$t3,$t5 # (b+n_odd)
for3:    
    bge $t3,$t5,endprgm
    li $v0,1 # print_int10()
    lw $a0,0($t3) # *p2
    syscall
    addiu $t3,$t3,4 # p2++
    j for3
endprgm:
    jr $ra