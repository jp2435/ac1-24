#       Align   Size    Offset
# acc   4       4       0
# nm    1       1       4
# grade 8       8       5->8
# quest 1       14      16 
# cq    4       4       30->32
# t_kvd 8       40

# Mapa de registos
# nv: $t0
# pt: $t1
# i: $t2
# j: $t3
# sum: $f2

    .data
const: .double 0.0
    .text
    .globl func3

func3:
    move $t0,$a0 # nv
    move $t1,$a1 # pt
    la $t5,const
    l.d $f2,0($t5) # max=0.0
    li $t2,0 # i=0
for:
    bge $t2,$t0,end_for # if i>=nv j end_for
    li $t3,0 # j=0
do:
    addiu $t4,$t1,16 # &(pt->quest)
    addu $t4,$t4,$t3 # &(pt->quest[j])
    l.d $f4,0($t4) # pt->quest[j]
    add.d $f2,$f2,$f4 # sum += pt->quest[j]
    addiu $t3,$t3,1 # j++
    
    addiu $t4,$t1,4 # &(pt->nm)
    lb $t4,0($t4) # (char) pt->nm
    bge $t3,$t4,do # if j>=(pt->nm) j do
end_do:
    addiu $t4,$t1,8 # &(pt->grade)
    l.d $f4,0($t4) # pt->grade
    div.d $f4,$f2,$f4 # sum/pt->grade
    cvt.w.d $f4,$f4 # Casting de Int
    mfc1 $t6,$f4
    #  $t1 = &pt->acc
    lw $t6,0($t1) # pt->acc=(int)sum/(pt->grade)

end_for:
    lw $t4,32($t1) # pt->cq
    mtc1 $t4,$f0
    cvt.d.w $f0,$f0 # Casting de double

    l.d $f0,8($t1) # pt->grade
    mul.d $f0,$f0,$f4 # (pt->grade)*(double)(pt->cq)
    # return em $f0
    jr $ra

