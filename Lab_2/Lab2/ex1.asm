bits 32 
global start        


extern exit, printf             
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data

segment code use32 class=code
    start:
        
        xor eax, eax
        xor ebx, ebx
        
        mov eax, -2
        mov ebx, -1
        div bl
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
