bits 32 
global start        


extern exit, printf            
import exit msvcrt.dll    
import printf msvcrt.dll 
   
segment data use32 class=data

    a db 127
    b dw 129
    
    print_frm db 'Rezultatul este: %d', 0
   
segment code use32 class=code
start:
    
    xor eax, eax
    
    mov al, [a]
    cbw
    add ax, [b]
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
  
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
