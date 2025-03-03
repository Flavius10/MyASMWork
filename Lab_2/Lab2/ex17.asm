bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data

    a db 14
    b db 2

    print_frm db 'Rezultatul este: %hu', 0
   
segment code use32 class=code
start:

    xor eax, eax
    mov al, [a]
    add al, [b]
    
    push eax 
    
    push print_frm
    call [printf]
    add esp, 6
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
