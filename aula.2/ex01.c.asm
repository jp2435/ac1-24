    .data
    .eqv val_1,0xe543
    .eqv print_int16,34
    .text
    .globl main

main: 
    ori $t0,$0,val_1

    nor $t1,$t0,$0 # Desta forma vai inverter os bit de bit em 
    li $v0,print_int16
    # ori $v0,$0,print_int16, display em hex 
    or $a0,$0,$t1
    syscall    

    jr $ra
