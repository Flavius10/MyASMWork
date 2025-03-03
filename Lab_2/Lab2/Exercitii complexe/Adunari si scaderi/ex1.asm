bits 32 
global start        


extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

; c-(a+d)+(b+d)
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
    
    mov al, [a]   ; al = a
    add al, [d]   ; al = a + d
    
    mov dl, [c]  ; ah = c
    sub dl, al  ; dl = c - (a + d)
    
    add dl, [b]
    add dl, [d]
    
    mov al, dl
    
    cbw
    
    push eax
    push print_frm
    call [printf]
    add esp, 6
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
