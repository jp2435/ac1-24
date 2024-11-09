# Mapa de registro
# $t0 -> cc
# $t1 -> ms
    .data
str1: .asciiz "Teste-Pratico-1"
    .text
    .globl main

main:
    la $t1,str1

while:
    beq $t1,'\0',endprgm
    lb $t0,0($t1) # cc = *ms
    # if_label
    bge $t0,'0',else
    li $t1,0 # ms = ''
    j endif
else:
    blt $t0,'a',endif
    bgt $t0,'z',endif
    addiu $t1,$t1,-0x20

endif:
    addiu $t1,$t1,1
    j while

endprgm:
    jr $ra

