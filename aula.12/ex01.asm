#                   Align   Dim     Off
# int(id_number)    4       4       0
# char(f_n[18])     1       18      4
# char(l_n[15])     1       15      22
# float(grade)      4       4       37->40
# student           4       44       

    .data
    .eqv MAX_STUD,4
    .eqv print_float,2
    .eqv print_str,4
    .align 2
st_array: .space 176 # 44*4=176
    .align 2
media: .space 4 # Valor float
str1: .asciiz "\nMedia: "
    .text
    .globl main
main:
    addiu $sp,$sp,-16
    sw $ra,0($sp)
    sw $s0,4($sp)
    sw $s1,8($sp)
    sw $s2,12($sp)
    # st_arry -> $s0
    # pmax -> $s1
    # &media -> $s2
    la $s0,st_array # &st_array
    la $s2,media # &media

    # Read_data execution
    # $a0, pointer array de Student_Struct
    # $a1, int (Max Stud)
    move $a0,$s0
    li $a1,MAX_STUD
    jal read_data

    # Max execution
    # $a0, pointer array de Student_Struct
    # $a1, int (Max Stud)
    # $a2, pointer de um Float
    # Return
        # $v0, pointer de Struct Student
    move $a0,$s0
    li $a1,MAX_STUD
    move $a2,$s2
    jal max
    move $s1,$v0 # pmax=max($a0,$a1,$a2)

    li $v0,print_str
    la $a0,str1
    syscall # print_str()
    li $v0,print_float
    l.s $f12,0($s2) # valor de media
    syscall # print_float()

    # print_student execution
    # $a0, pointer de Struct de Student
    move $a0,$s1
    jal print_student



    lw $ra,0($sp)
    addiu $sp,$sp,4
    jr $ra


