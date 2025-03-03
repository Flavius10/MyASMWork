bits 32 
global start        


extern exit, printf            
import exit msvcrt.dll   
import printf msvcrt.dll  
 
segment data use32 class=data

    a dw 34h
    b dw 78h
   
segment code use32 class=code
start:

    mov eax, a
    
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
