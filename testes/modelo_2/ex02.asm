    .data
constantes: .float -1.0,0.0,1.0
    .text
    .globl func2

func2:
    # $a0 -> $t0 -> Pointer de Float
    # $f12 -> $f2 -> Float(t)
    # $a1 -> $t1 -> Int(n)
    
    # Registos
    # a -> $t0
    # t ->  $f2
    # n -> $t1
    # oldg -> $f4
    # g -> $f6
    # s -> $f8
    # k: $t3
    move $t0,$a0
    mov.s $f2,$f12
    move $t1,$a1

    la $t4,constantes
    l.s $f4,0($t4) # oldg = -1.0
    l.s $f6,8($t4) # g = 1.0
    l.s $f8,4($t4) # s = 0.0

    li $t3,0 # k=0
for:
    bge $t3,$t1,end_for # if k>=n j end_for
while:
    sub.s $f10,$f6,$f4 # g-oldg
    c.le.s $f10,$f2 
    bc1t end_while  # if (g-oldg)<=t j end_while
    mov.s $f4,$f6 # oldg=g
    sll $t5,$t3,2 # k*4
    addu $t5,$t0,$t5 # &a[k]
    l.s $f10,0($t5) # a[k]
    add.s $f10,$f6,$f10 # g+a[k]
    div.s $f6,$f10,$f2 # g=(g+a[k])/t
    j while
end_while:
    add.s $f8,$f8,$f6 # s+=g
    s.s $f6,0($t5) # $t5->&a[k], a[k]=g

    addiu $t3,$t3,1 # k++
    j for
end_for:
    mtc1 $t1,$f10
    cvt.s.w $f10,$f10 # Casting Float
    div.s $f0,$f8,$f10 # return s/(float)n
    jr $ra

