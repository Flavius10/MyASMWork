;a-d+b+b+c 
;a,b,c,d - word 

bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    
    

segment data use32 class=data
    a dw 4
    b dw 3
    c dw 2
    d dw 2
    
    print_frm db "Rezulatul este: % d", 0
  
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov ax, [a]
    sub ax, [d]
    add ax, [b]
    add ax, [b]
    add ax, [c]

    cwde
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
  
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
