Calculadora na linguagem ASSEMBLY 486 que efectua as quatro operações aritméticas básicas sobre dois operandos inteiros. Para além disso, efectua operações lógicas (AND, OR, XOR), deslocamentos lógicos e rotações sobre números inteiros.

Este programa lê os operandos e operadores de um ficheiro no formato pós-fixo (notação polaca invertida). 

O resultado fica no mesmo ficheiro (removendo os operandos e operadores originais).

O programa aceita os 2 operandos (em hexadecimal) e o operador ( +, -, *, /, &, |, ^, SL, SR, RL, RR ), em linhas diferentes do ficheiro, sendo o resultado apresentado no mesmo ficheiro, no mesmo formato.

O programa detecta e indica no ficheiro situações de "overflow".

# COMO EXECUTAR:

num ficheiro "dados.txt" colocar os dois operandos e o operador. depois de executar o programa, esse ficheiro "dados.txt" irá ser alterado com o resultado final

exemplo:

"28
3
+"

ou

"23 
4
+
6
-"
