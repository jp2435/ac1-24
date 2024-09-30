# Aula 2

~(val1 | 0)

val1 = 0xF3e1
val1 | 0 = 1111_0011_1110_0001 | 0000_0000_0000_0000
<=> 1111_0011_1110_0001 <=> ~(1111_0011_1110_0001) <=> 0000_1100_0001_1110 = 0x0c1e

Desta forma apenas usando os operadores a disposição conseguimos fazer um negação bitwise de um valor, apenas usando o _nor_ com _zero_