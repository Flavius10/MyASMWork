;(d+d-b)+(c-a)+d 
;a,b,c,d - byte

bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    
    

segment data use32 class=data
    a db 4
    b db 3
    c db 2
    d db 2
    
    print_frm db "Rezulatul este: % d", 0
  
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [d]
    add al, [d]
    sub al, [b]  ; (d+d-b)
    
    add al, [c]
    sub al, [a]
    add al, [d]
    
    cbw
    cwde
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
  
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
