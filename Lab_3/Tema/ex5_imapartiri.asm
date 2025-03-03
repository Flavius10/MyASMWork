; a,b,d-byte; c-word; e-doubleword; x-qword
; x + a/b + c*d - b/c + e = 10 + 10 / 5 + 4 * 7 - 5 / 4 + 10 = 10 + 2 + 28 - 1 + 10 = 49

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data 
   
    a db 10
    b db 5
    c dw 4
    d db 7
    e dd 10
    x dq 10
   
   print_frm db 'Rezultatul este %lld', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    mov bl, [b]
    div bl  ; al = ax / b = a / b
    
    mov cl, al ; cl = al = a / b
    xor eax, eax
    mov ax, [c]
    xor ebx, ebx
    mov bl, [b]
    mul bl ; dx:ax = ax * bx
    
    push dx
    push ax
    pop eax 
    
    add eax, ecx  ; eax = a / b + b * c
    
    xor ecx, ecx
    mov ecx, eax ; ecx = a / b + b * c
    xor eax, eax
    
    mov al, [b]
    xor edx, edx ; dx:ax = b
    
    mov bx, [c]
    div bx ; ax = b / c
    
    add eax, [e]
    add eax, ecx
    
    xor ecx, ecx
    xor edx, edx
    
    add eax, [x]
    add edx, [x + 4]
   
    push edx
    push eax
    push print_frm
    call [printf]
    add esp, 3 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
