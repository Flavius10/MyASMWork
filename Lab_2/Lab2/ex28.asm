bits 32 
global start        


extern exit, printf              
import exit msvcrt.dll   
import printf msvcrt.dll  
 
segment data use32 class=data

    a db 13
    b dw 5
    
    catul_frm db 'Catul este: %d', 10, 13, 0
    rest_frm db 'Restul este: %d', 0
   
segment code use32 class=code
start:
   
    xor eax, eax
    xor edx, edx
    
    mov al, [a]
    cbw         ; ax = al
    cwd         ; dx:ax = ax
    
    div word [b]
    
    push edx
    
    push eax
    push catul_frm
    call [printf]
    add esp, 8
    
    push rest_frm
    call [printf]
    add esp, 8
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
