; a-word; b-byte; e-doubleword; x-qword
; x-b+8+(2*a-b)/(b*b)+e

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data 
   
    a dw 11
    b db 100
    e dd 10
    x dq 10
   
   print_frm db 'Rezultatul este %d', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov bx, 2
    mov ax, [a]
    
    imul bx ; dx:ax = ax * bx
    push dx
    push ax
    pop eax  ; eax = 2 * a
    
    xor ebx, ebx
    mov ebx, eax ; ebx = 2 * a
    xor eax, eax
    
    mov eax, ebx
    
    mov al, [b]
    cbw
    cwde
    
    sub ebx, eax  ; ebx = 2 * a - b
    xor eax, eax
    
    mov al, [b]
    imul byte [b]  ; ax = b * b
    cwde
    
    mov ecx, eax  ; ecx = eax = b * b
    xor eax, eax
    
    mov eax, ebx
    cdq
    idiv ecx ; eax = edx:eax / ecx, eax = (2*a-b)/(b*b)
    
    xor ecx, ecx
    xor ebx, ebx
    xor edx, edx
   
    add eax, 8
    add eax, [e]
    
    mov edx, eax ; edx = eax = (2*a-b)/(b*b) + 8 + e
    xor eax, eax
    
    mov al, [b]
    cbw
    cwde
    sub edx, eax
    
    xor eax, eax
    mov eax, edx
    
    cdq
    add eax, [x]
    
    push eax
    push print_frm
    call [printf]
    adc esp, 2 * 4
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
