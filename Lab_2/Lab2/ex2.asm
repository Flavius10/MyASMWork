bits 32 
global start        


extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data
    
    a resd 1
    format_print db "%d", 0
    
segment code use32 class=code
    start:
        
        xor eax, eax
        xor ebx, ebx
        
        mov eax, 1000
        
        mov dword [a], eax
        
        push dword [a]
        push format_print
        call [printf]
        add esp, 2 * 4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
