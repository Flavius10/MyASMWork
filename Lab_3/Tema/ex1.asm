; a - byte, b - word, c - double word, d - qword
; (a+b)-(a+d)+(c-a) 

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data
   
   a db 1
   b dw 3
   c dd 4
   d dq 2
   
   print_frm db 'Rezultatul este %lld', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    mov bx, [b]
    add ax, bx  ; ax = a + b
    
    xor ebx, ebx
    mov bl, [a]
    sub ax, bx
    
    xor ebx, ebx
    mov bl, [a]
    sub ax, bx
    
    add eax, [c]
    xor edx, edx
    
    xor ebx, ebx
    xor ecx, ecx
 
    mov ebx, [d]
    mov ecx, [d + 4]
    
    add eax, ebx
    add edx, ecx
    
    push edx
    push eax
    push print_frm
    call [printf]
    add esp, 3 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
