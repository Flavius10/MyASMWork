; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
; c-(d+a)+(b+c) = 

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data
   
   a db 4
   b dw 7
   c dd 3
   d dq 10
   
   print_frm db 'Rezultatul este %d', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov ax, [b]
    cwde
    add eax, [c] ; eax = c + b

    mov ecx, eax ; ecx = eax = c + b
    xor eax, eax
    
    add ecx, [c]; ecx = c + c + b
    
    add al, [a]
    cbw
    cwde
    sub ecx, eax ; ecx = c + c + b - a
    
    xor eax, eax
    mov eax, ecx ; eax = ecx
    
    cdq
    
    sub eax, [d]
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
