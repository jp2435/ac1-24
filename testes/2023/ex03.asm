# Mapa de registro
# $t0 -> i
# $t1 -> max1
# $t2 -> max2
# $t3 -> array
# $t4 -> i*4
    .data
    .eqv SIZE,5
    .align 2
array: .word 5,27,3,11,56
    .text
    .globl main

main:
    la $t3,array
    li $t1,1
    sll $t1,$t1,31 # max1 = 1<<31
    ori $t2,$t1,0 # max2 = max1
    li $t0,0 # i = 0
for: 
    bge $t0,SIZE,endfor
    sll $t4,$t0,2 # i*4
    addu $t5,$t3,$t4 # array[i] end.
    lw $t5,0($t5) # Valor em array[i]

    # if_label
    ble $t5,$t1,else
    move $t2,$t1 # max2 = max1
    move $t1,$t5 # max1 = array[i][$t5]
    j endif
else:
    ble $t5,$t2,endif
    bge $t5,$t1,endif
    move $t2,$t5

endif:
    addi $t0,$t0,1 # i++
    j for
endfor:
    jr $ra