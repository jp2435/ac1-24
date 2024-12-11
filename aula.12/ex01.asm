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
    .eqv read_int,5
    .eqv read_float,6
    .eqv read_str,8

    .align 2
st_array: .space 176 # 44*4=176
    .align 2
media: .space 4 # Valor float
str1: .asciiz "\nMedia: "
str2: .asciiz "NMec: "
str3: .asciiz "Primeiro Nome: "
str4: .asciiz "Ultimo Nome: "
str5: .asciiz "Nota: "
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
    lw $s0,4($sp)
    lw $s1,8($sp)
    lw $s2,12($sp)
    addiu $sp,$sp,16
    jr $ra

#    Functions    #

# $a0, pointer array de Student_Struct
# $a1, int (Max Stud)
# void r_d(student *st,int ns)

# $a0 -> $s0
# $a1 -> $s1
# i -> $s2
read_data:
    addiu $sp,$sp,-16
    sw $ra,0($sp)
    sw $s0,4($sp)
    sw $s1,8($sp)
    sw $s2,12($sp)

    move $s0,$a0
    move $s1,$a1
    li $s2,0 # i=0
for_rd:
    bge $s2,$s1,end_read_data # if i>=ns j end_for
    mulu $t0,$s2,44 # i*44, array de struct jump 44 to 44
    addu $t0,$s0,$t0 # &st[i]

    # Nmec
    li $v0,print_str
    la $a0,str2
    syscall
    li $v0,read_int
    syscall
    sw $v0,0($t0) # st[i].id_number=read_int()

    # Primeiro Nome
    li $v0,print_str
    la $a0,str3
    syscall
    li $v0,read_str
    addiu $a0,$t0,4 # $a0=st[i].first_name
    li $a1,17 # Numero maximo de caracteres
    syscall

    # Ultimo Nome
    li $v0,print_str
    la $a0,str4
    syscall
    li $v0,read_str
    addiu $a0,$t0,22 # $a0=st[i].last_name
    li $a1,14 # Numero maximo de caracteres
    syscall

    # Nota
    li $v0,print_str
    la $a0,str5
    syscall
    li $v0,read_float
    syscall
    s.s $f0,40($t0) # st[i].grade = read_float()

    addiu $s2,$s2,1 # i++
    j for_rd

# Label end_read_data = end_for
end_read_data:
    lw $ra,0($sp)
    lw $s0,4($sp)
    lw $s1,8($sp)
    lw $s2,12($sp)
    addiu $sp,$sp,16
    jr $ra

max:
print_student:
    jr $ra