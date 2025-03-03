; (2*d+e)/a 
; a,b,c,d-byte, e,f,g,h-word

bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    
    

segment data use32 class=data
    a db 4
    b db 6
    c db 2
    d db 4
    
    e dw 5
    f dw 8
    g dw 6
    h dw 3
    
    print_frm db "Catul este: %d", 0
  
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, 2
    mul byte [d]  ; ax = 2 * d
    add ax, [e]
    
    mov bl, [a]
    
    idiv bl  ; al = ax / bl
    
    xor ah, ah
    cbw
    cwde
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
  
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
