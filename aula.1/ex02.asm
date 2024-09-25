    .data
    .text
    .globl main
main:
    ori $t0,$0,3 # valor de x
    ori $t2,$0,8
    add $t1,$t0,$t0 # 2x
    sub $t1,$t1,$t2 # 2x-8s

    jr $ra
