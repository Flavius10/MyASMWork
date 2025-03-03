; e-a*a 

bits 32 

global start        

extern exit, printf               
import exit msvcrt.dll   
import printf msvcrt.dll 
  
segment data use32 class=data

    a db 5
    b db 6 
    c db 7
    d db 2
    e dw 1 
    f dw 8
    g dw 6
    h dw 9
    
    print_frm db 'Rezultatul este: %d', 0
    cat_frm db 'Catul este: %d', 10, 13, 0
    rest_frm db 'Restul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    mov bl, [a]
    imul bl  ; ax = a * a*a
    
    mov dx, [e]
    sub dx, ax
    
    xor eax, eax
    mov ax, dx
    
    cwde
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
  
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
