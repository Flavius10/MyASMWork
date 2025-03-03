; a-word; b-byte; e-doubleword; x-qword
; x-b+8+(2*a-b)/(b*b)+e

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data 
   
    a dw 11
    b db 3
    e dd 10
    x dq 10
   
   print_frm db 'Rezultatul este %lld', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, 8
    sub al, [b]
    mov cl, al ; cl = 8 - b
    
    xor eax, eax
    
    mov bl, 2
    mov ax, [a]
    mul bx ; dx:ax = a * 2
    
    push dx
    push ax
    pop eax
    
    sbb al, [b] ; eax = a * 2 - b
    xor ebx, ebx
    mov ebx, eax ; ebx = eax
    
    xor eax, eax
    mov al, [b]
    mul al ; ax = b * b
    
    xor edx, edx
    mov edx, ebx
    xor ebx,ebx
    mov ebx, eax ; ebx = eax = b * b
    mov eax, edx ; eax = ebx = a * 2 - b
    
    xor edx, edx ; edx:eax = a * 2  - b
    
    div ebx ; edx:eax / ebx = eax
    add eax, [e]
    xor edx, edx ; edx:eax = 
    
    add eax, [x]
    add edx, [x + 4]
    add eax, ecx
    
    push edx
    push eax
    push print_frm
    call [printf]
    add esp, 3 * 4
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
