; a - byte, b - word, c - double word, d - qword
; (a+c)-b+a + (d-c) = 16 

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data
   
   a db 10
   b dw 7
   c dd 10
   d dq 3
   
   print_frm db 'Rezultatul este %lld', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    add al, [a]
    sub ax, [b]
    
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov ecx, [d + 4]
    mov ebx, [d]
    
    add edx, ecx
    add eax, ebx
    
    push edx
    push eax
    push print_frm
    call [printf]
    add esp, 3 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
