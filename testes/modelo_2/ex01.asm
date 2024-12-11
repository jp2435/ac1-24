    .data
    .eqv SIZE,15
    .eqv print_int,1
    .eqv print_str,4
str1: .asciiz "Invalid argc"
    .text
    .globl func1
func1:
    # $a0 -> fl(pointer[int])
        # $a0->$s0
    # $a1 -> k  (int)
        # $a1 -> $s1
    # $a2 -> av(pointer[char])
        # $a2 -> $s2
    # i -> $s3
    # res -> $s4
    addiu $sp,$sp,-24
    sw $ra,0($sp)
    sw $s0,4($sp)
    sw $s1,8($sp)
    sw $s2,12($sp)
    sw $s3,16($sp)
    sw $s4,20($sp)
    move $s0,$a0
    move $s1,$a1
    move $s2,$a2
    move $s3,$a3
    move $s4,$a4


    # if_label
    blt $s1,2,else # if(k<2) j else
    bgt $s1,SIZE,else # if(k>SIZE) j else
    li $s3,2 # i=2
do:
    addu $a0,$s2,$s3 # &av[i]
    jal toi # toi(av[i])

    sll $t0,$s3,2 # i*4
    addu $t0,$s0,$t0 # &fl[i]
    sw $v0,0($t0) # fl[i] = toi(av[i])
    addiu $s3,$s3,$s3 # i++
    blt $s3,$s1,do
    # end of do
    move $a0,$s0
    move $a1,$s1
    jal avz
    move $s4,$v0 # res=avz(fl,k)=avz($a0,$a1)

    li $v0,print_int
    move $a0,$s4
    syscall
    j end_func1

else:
    li $v0,print_str
    la $a0,str1
    syscall
    li $s4,-1 # res=-1
end_func1:
    move $v0,$s4 # return res

    lw $ra,0($sp)
    lw $s0,4($sp)
    lw $s1,8($sp)
    lw $s2,12($sp)
    lw $s3,16($sp)
    lw $s4,20($sp)
    addiu $sp,$sp,24
    
    jr $ra