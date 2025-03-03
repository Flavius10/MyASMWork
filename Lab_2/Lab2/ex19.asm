bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll
    
segment data use32 class=data

    a dw 12
    b db 4
    
    catul_frm db 'Catul este: %d', 10, 13, 0
    restul_frm db 'Restul este: %d', 0
   
segment code use32 class=code
start:
   
    xor eax, eax
    xor edx, edx
    
    mov ax, [a]
    div byte [b]
    
    mov dh, ah
    xor ah, ah
    
    push edx
    
    push eax
    push catul_frm
    call [printf]
    add esp, 8
    
    push restul_frm
    call [printf]
    add esp, 8
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
