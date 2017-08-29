;;; Trabalho 0.1: Funções matemáticas check, pede dois números e operador. Dá resultado
;;; Trabalho 0.2: Mensagem inicial com a apresentação dos alunos
;;; Trabalho 0.3: Menu Calculadora/Informações
;;; Trabalho 0.4: Menu c/ sair
;;; Trabalho 0.5: Limpar ecrã quando inicia (system("cls");)
;;; Trabalho 0.6: Esperar pela acção do utilizador quando entra menu informações e imprime resultado (system("pause");)
;;; Trabalho 0.7: Apresenta erro quando opção invalida
;;; Trabalho 0.8: Operação & e SL
;;; Trabalho 0.9: Operação | e ^
;;; Trabalho 1.0: Apresenta erro quando operador inválido
;;; Trabalho 1.1: Lê e escreve do ficheiro
;;; Trabalho 1.2: Operação SR
;;; Trabalho 1.3: Apresenta lista de operadores quando operador válido
;;; Trabalho 1.4: Operação RL e RR (falta confirmar se está certo)
;;; Trabalho 1.5: Programa já lê ficheiro completo
;;; Trabalho 1.6: Operações completas. Pronto para teste
;;; Trabalho 1.7: SL, SR, RL e RR são chamados correctamente
;;; Trabalho 1.8: Apresenta erro quando ficheiro não existe
;;; Trabalho 1.9: Overflow
;;; Trabalho 2.0 (final): Apresenta erros quando não existe um dos números. Código mais organizado. Final

section .data

fich		db		"dados.txt", 0

LINHA		db		10	; Código do \n

MAX_PALAVRA equ 40

limpaterm	db		27,"[H",27,"[2J"
tlimpaterm	equ		$ - limpaterm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      MENSAGENS    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

msg1		db		0xa,"------------------------------------------------------"
lmsg1		equ		$ - msg1

msg2		db		0xa,"--- Trabalho Final de Arquitectura de Computadores ---"
lmsg2		equ		$ - msg2

msg3		db		0xa,"------------------------------------------------------", 0xa
lmsg3		equ		$ - msg3

msg4		db		0xa,"Trabalho realizado por:"
lmsg4		equ		$ - msg4

msg5		db		0xa,"- Bruno Antunes, nº21403819"
lmsg5		equ		$ - msg5

msg6		db		0xa,"- Nuno Nelas, nº21401549"
lmsg6		equ		$ - msg6

msg7		db		0xa,"- Miguel Soeiro, nº21401797", 0xa
lmsg7		equ		$ - msg7

s1		db		0xa,"Escolha uma das seguintes opções"
ts1		equ		$ - s1

s2		db		0xa,"1 - Calculadora"
ts2		equ		$ - s2

s3		db		0xa,"2 - Informações"
ts3		equ		$ - s3

s4		db		0xa,"0 - Sair", 0xa
ts4		equ		$ - s4

s5		db		0xa,"Opção: "
ts5		equ		$ - s5

s6		db		0xa,"Opção inválida. Por favor, insira um número inteiro entre 0 e 2."
ts6		equ		$ - s6

s7		db		0xa,"Operador inválido. Por favor, insira um operador válido.",0xa,"+ - Somar",0xa,"- - Subtrair",0xa,"* - Multiplicar",0xa,"/ - Dividir",0xa,"& - AND",0xa,"| - OR",0xa,"^ - XOR",0xa,"SL - Shift Left",0xa,"SR - Shift Right",0xa,"RL - Rotate Left",0xa,"RR - Rotate Right",0xa 
ts7		equ		$ - s7

s8		db		0xa,"Operação realizada com sucesso. Obrigado.", 0xa
ts8		equ		$ - s8

s9      db      0xa,"Ficheiro não encontrado.",0xa,"Por favor crie um ficheiro de texto com o nome 'dados.txt' e introduza os números e operadores da seguinte forma:",0xa,"1º Número",0xa,"2º Número",0xa,"Operador",0xa
ts9     equ     $ - s9

s10     db      0xa,"Foi dectada uma situação de overflow."
ts10    equ     $ - s10

s11      db      0xa,"Não foi encontrado o 1º Número.",0xa,"Por favor verifique se os números e operadores encontram-se da seguinte forma:",0xa,"1º Número",0xa,"2º Número",0xa,"Operador",0xa
ts11    equ     $ - s11

s12      db      0xa,"Não foi encontrado o 2º Número.",0xa,"Por favor verifique se os números e operadores encontram-se da seguinte forma:",0xa,"1º Número",0xa,"2º Número",0xa,"Operador",0xa
ts12    equ     $ - s12

troll   db      0xa,"░░░░░░░░░▄██████████▄▄░░░░░░░░",0xa,"░░░░░░▄█████████████████▄░░░░░",0xa,"░░░░░██▀▀▀▀▀▀▀▀▀▀▀████████░░░░",0xa,"░░░░██░░░░░░░░░░░░░░███████░░░",0xa,"░░░██░░░░░░░░░░░░░░░████████░░",0xa,"░░░█▀░░░░░░░░░░░░░░░▀███████░░",0xa,"░░░█▄▄██▄░░░▀█████▄░░▀██████░░",0xa,"░░░█▀███▄▀░░░▄██▄▄█▀░░░█████▄░",0xa,"░░░█░░▀▀█░░░░░▀▀░░░▀░░░██░░▀▄█",0xa,"░░░█░░░█░░░▄░░░░░░░░░░░░░██░██",0xa,"░░░█░░█▄▄▄▄█▄▀▄░░░░░░░░░▄▄█▄█░",0xa,"░░░█░░█▄▄▄▄▄▄░▀▄░░░░░░░░▄░▀█░░",0xa,"░░░█░█▄████▀██▄▀░░░░░░░█░▀▀░░░",0xa,"░░░░██▀░▄▄▄▄░░░▄▀░░░░▄▀█░░░░░░",0xa,"░░░░░█▄▀░░░░▀█▀█▀░▄▄▀░▄▀░░░░░░",0xa,"░░░░░▀▄░░░░░░░░▄▄▀░░░░█░░░░░░░",0xa,"░░░░░▄██▀▀▀▀▀▀▀░░░░░░░█▄░░░░░░",0xa,"░░▄▄▀░░░▀▄░░░░░░░░░░▄▀░▀▀▄░░░░",0xa,"▄▀▀░░░░░░░█▄░░░░░░▄▀░░░░░░█▄░░",0xa,"█░░░░░░░░░░░░░░░░░░░░░░░░░░▀█▄",0xa,"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",0xa,"█▄░░█ █▀▀█ ▀▀█▀▀░░█▀▀█ █▀▀█ █▀▀▄",0xa,"█░█░█ █░░█ ░░█░░░░█▀▀▄ █▄▄█ █░░█",0xa,"█░░▀█ █▄▄█ ░░█░░░░█▄▄█ █░░█ █▄▄▀",0xa,"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",0xa
ltroll  equ     $ - troll

fimmsg     db    0xa,"Fim do Programa. Obrigado.",0xa
lfimmsg    equ   $ - fimmsg

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      VARIÁVEIS    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

num1 		dd		0
num2 		dd		0
nfich		dd		0	; nº do ficheiro aberto
nlidos		dd		0	; vai conter o nº de carateres lidos

section .bss

MAXFICH		equ		2048
strfich		resb		MAXFICH	;string que vai guardar o conteúdo do ficheiro

MAX		equ		9
strnum		resb		MAX

opc		resb		2

section .text

global _start

_start:
    mov     eax, ds
    mov     es, eax

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      FUNÇÃO LIMPAR ECRÃ   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

limpa:
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, limpaterm
    mov		edx, tlimpaterm
    int		0x80
    jmp		menu
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      APRESENTAÇÃO PROGRAMA (MENSAGENS)    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

menu:
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, msg1
    mov		edx, lmsg1
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, msg2
    mov		edx, lmsg2
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, msg3
    mov		edx, lmsg3
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, s1
    mov		edx, ts1
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, s2
    mov		edx, ts2
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, s3
    mov		edx, ts3
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, s4
    mov		edx, ts4
    int		0x80

    mov		eax, 4
    mov		ebx, 1
    mov		ecx, s5
    mov		edx, ts5
    int		0x80
    
    mov		eax, 3
    mov		ebx, 0
    mov		ecx, opc
    mov		edx, 2
    int		0x80
    
    mov 	ah, [opc]
    sub 	ah, '0'
    
    cmp 	ah, 1
    je 		calculadora
    
    cmp 	ah, 2
    je 		info
    
    cmp		ah, 0
    je 		acabou
    
    jne 	erro1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      INFORMAÇÕES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

info:
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, msg4
    mov		edx, lmsg4
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, msg5
    mov		edx, lmsg5
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, msg6
    mov		edx, lmsg6
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, msg7
    mov		edx, lmsg7
    int		0x80
    
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, troll
    mov     edx, ltroll
    int     0x80

    mov		eax, 3
    mov		ebx, 0
    mov		ecx, opc
    mov		edx, 2
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, limpaterm
    mov		edx, tlimpaterm
    int		0x80
    jmp		menu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      CALCULADORA (ABRIR FICHEIRO)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

calculadora:
    ; Abrir o ficheiro de dados (para leitura)
    mov		eax, 5			; função SYS_OPEN
    mov		ebx, fich		; nome do ficheiro a abrir
    mov		ecx, 0			; 0_RDONLY, abrir o ficheiro apenas para leitura
    int		0x80			; invocar o sistema operativo
    mov		[nfich], eax		; NFICH guarda nº do ficheiro aberto
    
    cmp     dword[nfich], 0
    jle     errofich

    ; Ler o conteúdo do ficheiro
    mov		eax, 3			    ; função SYS_READ
    mov		ebx, [nfich]		; ler do ficheiro
    mov		ecx, strfich		; buffer para onde vai ser lido o ficheiro
    mov		edx, MAXFICH		; nº máximo de caracteres a ler
    int		0x80

    ; A função deixa no EAX o nº de caracteres lidos
    mov		[nlidos], eax		; guardar o tamanho do conteúdo do ficheiro

    cmp     eax, 0
    je      erro4

    ; Fechar o ficheiro
    mov		eax, 6			; SYS_CLOSE
    mov		ebx, [nfich]		; nº do ficheiro que queremos fechar
    int		0x80
    
    ; Processar a STRFICH
    cld					; DF=0 para autoincrementar o ESI e o EDI
    mov		esi, strfich	
    mov		edi, strnum
    xor		ebx, ebx		; EBX=0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      CALCULADORA (PEDE NÚMERO 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
numero1:
    lodsb				; carrega um caracter de STRFICH no AL
    cmp		al, [LINHA]		; compara AL com \n
    je		fim_num1		; se for \n, terminou o numero1
    stosb				; copia o caracter para o STRNUM
    inc		ebx			; contabiliza mais um caracter
    jmp		numero1			; vai processar o próximo digito do número
    
fim_num1:
    push	esi			; salvaguardar o ESI por causa da função ATOI

    ; Converte texto para inteiro hexadecimal
    ; Em C seria: num1 = atoi(strnum, ebx);
    push	ebx
    push	strnum
    call	atoi
    add		esp, 8
    mov		[num1], eax
    
    pop		esi			; Repor o valor do ESI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      CALCULADORA (PEDE NÚMERO 2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
proximo:
    ; Processar o número 2
    mov		edi, strnum
    xor		ebx, ebx		; EBX=0

numero2:
    lodsb				; carrega um caracter de STRFICH no AL
    cmp		al, [LINHA]		; compara AL com \n
    je		fim_num2		; se for \n, terminou o numero2
    stosb				; copia o caracter para o STRNUM
    inc		ebx			; contabiliza mais um caracter
    jmp		numero2			; vai processar o próximo digito do número
     
fim_num2:
    push	esi			; salvaguardar o ESI por causa da função ATOI
    
    cmp     ebx, 0
    je      erro5

    ; Converte texto para inteiro hexadecimal
    ; Em C seria: num1 = atoi(strnum, ebx);
    push	ebx
    push	strnum
    call	atoi
    add		esp, 8
    mov		[num2], eax
    
    pop		esi			; Repor o valor do ESI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      CALCULADORA (PEDE NÚMERO OPERADOR)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
operador:
    ; Ler o operador na STRFICH
    lodsb				; o ESI estava a apontar para o operador
    cmp		al, '+'
    je		soma
    
    cmp		al, '-'
    je		subtrai

    cmp		al, '*'
    je		multiplica
    
    cmp		al, '/'
    je		divide
    
    cmp		al, '&'
    je		conjuga
    
    cmp		al, '|'
    je		disjunta
    
    cmp		al, '^'
    je		ouexclusivo
     
    cmp     al, 'S'
    je      shift

    cmp     al, 'R'
    je      rotate

shift:     
    
    lodsb
    cmp		al, 'L'
    je		SL

    cmp     al, 'R'
    je      SR

rotate:

    lodsb
    cmp		al, 'L'
    je		RL
    
    cmp		al, 'R'
    je		RR

    jne		erro2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      FUNÇÕES MATEMÁTICAS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

soma:
    mov		eax, [num1]
    add		eax, [num2]
    jo      erro3
    mov		[num1], eax
    jmp		imprime

subtrai:
    mov		eax, [num1]
    sub		eax, [num2]
    jo      erro3
    mov		[num1], eax
    jmp		imprime

multiplica:
    mov		eax, [num1]
    mov		ebx, [num2]
    mul		ebx
    jo      erro3
    mov		[num1], eax
    jmp		imprime

divide:
    xor		edx, edx
    mov		eax, [num1]
    mov		ebx, [num2]
    div		ebx
    mov		[num1], eax
    jmp		imprime

conjuga:
    mov		ebx, [num1]
    and		ebx, [num2]
    mov		[num1], ebx
    jmp		imprime
    
disjunta:
    mov		ebx, [num1]
    or		ebx, [num2]
    mov		[num1], ebx
    jmp		imprime
    
ouexclusivo:
    mov		ebx, [num1]
    xor		ebx, [num2]
    mov		[num1], ebx
    jmp		imprime
	
SL:
    mov		ebx, [num1]
    mov		ecx, [num2]
    shl		ebx, cl
    jo      erro3
    mov		[num1], ebx
    jmp		imprime
    
SR:
    mov		ebx, [num1]
    mov		ecx, [num2]
    shr		ebx, cl
    jo      erro3
    mov		[num1], ebx
    jmp		imprime
    
RL:
    mov		ebx, [num1]
    mov		ecx, [num2]
    rol		ebx, cl
    jo      erro3
    mov		[num1], ebx
    jmp		imprime
    
RR:
    mov		ebx, [num1]
    mov		ecx, [num2]
    ror		ebx, cl
    jo      erro3
    mov		[num1], ebx
    jmp		imprime

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      TRANSFORMA RESULTADO EM STRING    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    lodsb

imprime:
    inc		esi
    
    ; Verificar se chegamos ao fim da STRFICH
    ; ESI-STFCH-[NLIDOS] >= 0 acabou
    mov 	eax, esi
    sub 	eax, strfich
    sub 	eax,[nlidos]
    cmp 	eax, 0
    jge 	imprime2
    
    jmp 	proximo
    
imprime2:
    ; Converte número para texto
    ; Em C seria: itoa (res, strnum);
    push	strnum
    push	dword[num1]
    call	itoa
    add		esp, 8
    
    ; Abrir o ficheiro para escrita
    mov		eax, 5			; SYS_OPEN
    mov		ebx, fich		; nome do ficheiro
    mov		ecx, 01101q		; 0_WRONLY | 0_CREAT | 0_TRUNC
    mov		edx, 0644q		; permissões de criação do ficheiro
    int		0x80
    mov		[nfich], eax		; guardar o nº do ficheiro aberto
    
    ; Imprime  resultado
    mov		eax, 4
    mov		ebx, [nfich]
    mov		ecx, strnum
    mov		edx, 8
    int		0x80
    
    ; Imprime linha em branco
    mov		eax, 4
    mov		ebx, [nfich]
    mov		ecx, LINHA
    mov		edx, 1
    int		0x80
    
    ; Fechar o ficheiro
    mov		eax, 6			; SYS_CLOSE
    mov		ebx, [nfich]
    int		0x80

sucesso:
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, s8
    mov		edx, ts8
    int		0x80

    mov		eax, 3
    mov		ebx, 0
    mov		ecx, opc
    mov		edx, 2
    int		0x80
    
    mov		eax, 4
    mov		ebx, 1
    mov		ecx, limpaterm
    mov		edx, tlimpaterm
    int		0x80
    jmp		menu
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      FUNÇÕES DO PROGRAMA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Converte texto para inteiro hexadecimal
    ; Em C seria: int atoi(char strnum[], int nlidos);
atoi:
    push	ebp
    mov		ebp, esp
    mov		esi, [ebp+8]		; colocar no ESI string a converter
    cld					; DF=0, para autoincrementar o ESI
    mov		ecx, [ebp+12]		; ECX=nº de carateres a processar
    xor		eax, eax		; mov eax, 0
    xor		edx, edx		; mov edx, 0

converte:
    lodsb				; carrega byte da string no AL
    cmp		al, 'A'
    jb		digito			; Se for < 'A', então é algarismo
    add		al, 9			; Se for letra, somar 9

digito:
    and		al, 0x0F		; Deixa passar 4 bits da direita
    shl		edx, 4			; Arranja espaço para os próx 4 bits
    add		edx, eax		; Guarda os 4 bits no registo destino
    loop	converte
    mov		eax, edx		; Deixa no EAX o retorno da função (por convenção)
    pop		ebp
    ret
  
    ; Converte número para texto
    ; Em C seria: void itoa(int num, char* strnum);
itoa:
    push	ebp
    mov		ebp, esp
    mov		ecx, 8			; Vamos processar 8 dígitos hexadecimais
    cld					; DF=0, para autoincrementar o EDI
    mov		edi, [ebp+12]		; EDI aponta para a string de destino
    mov		edx, [ebp+8]		; colocar o nº a converter (num) no EDX

ciclo:
    rol		edx, 4			; Roda EDX para deixar dígito à direita
    mov		eax, edx		; O número vai ser processado no EAX
    and		eax, 0x0000000F		; Máscara p/ deixar passar só o dígito da direita
    cmp		al, 9
    ja		letra			; Se AL>9, salta para letra
    add		al, 48			; Se for dígito, somar 48
    jmp		fim			; Se for dígito, salta para não somar 55

letra:
    add		al, 55			; Se for letra, somar 55

fim:
    stosb				; Copia o caráter do AL para a STRNUM
    loop	ciclo			; Executa o ciclo 8 vezes (valor q está no ECX)
    pop		ebp
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      SAIR DO PROGRAMA  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
acabou:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, fimmsg
    mov     edx, lfimmsg
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, opc
    mov     edx, 2
    int     0x80
    
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, limpaterm
    mov     edx, tlimpaterm
    int     0x80
    jmp     fimprog

fimprog:
    mov		eax, 1
    mov		ebx, 0
    int		0x80

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      ERROS 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;menu, opção inválida
erro1:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, s6
    mov     edx, ts6
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, opc
    mov     edx, 2
    int     0x80
    
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, limpaterm
    mov     edx, tlimpaterm
    int     0x80
    jmp     menu

;;operador inválido
erro2:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, s7
    mov     edx, ts7
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, opc
    mov     edx, 2
    int     0x80
    
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, limpaterm
    mov     edx, tlimpaterm
    int     0x80
    jmp     menu

;;detecta overflow
erro3:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, s10
    mov     edx, ts10
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, opc
    mov     edx, 2
    int     0x80
    
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, limpaterm
    mov     edx, tlimpaterm
    int     0x80
    jmp     menu

;;não encontrou número1
erro4:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, s11
    mov     edx, ts11
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, opc
    mov     edx, 2
    int     0x80

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, limpaterm
    mov     edx, tlimpaterm
    int     0x80
    jmp     menu

;;não encontrou número2
erro5:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, s12
    mov     edx, ts12
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, opc
    mov     edx, 2
    int     0x80

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, limpaterm
    mov     edx, tlimpaterm
    int     0x80
    jmp     menu

;;ficheiro inválido
errofich:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, s9
    mov     edx, ts9
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, opc
    mov     edx, 2
    int     0x80

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, limpaterm
    mov     edx, tlimpaterm
    int     0x80
    jmp     menu