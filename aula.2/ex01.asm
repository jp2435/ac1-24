    .data
    .eqv val_1,0x5c1b
    .eqv val_2,0xa3e4
    .text
    .globl main

main:
    ori $t0,$0,val_1
    ori $t1,$0,val_2
    
    and $t2,$t0,$t1 # val_1 &(AND) val_2
    or $t3,$t0,$t1 # val_1 |(OR) val_2
    nor $t4,$t0,$t1 # !(val_1|val_2)
    xor $t5,$t0,$t1 # xor

    jr $ra
