bits 32 
global start        


extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

; (c+d)-(a+d)+b  
segment data use32 class=data
    
    a db 1
    b db 2
    c db 3
    d db 4
    
    print_frm db 'Rezultatul este: %hi', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    
    mov al , [c]
    add al, [d]
    
    mov dl, [a]
    add dl, [d]
    sub al, dl
    
    add al, [b]
    
    cbw
    
    push eax
    push print_frm
    call [printf]
    add esp, 6
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
