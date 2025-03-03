; (a-c)*3+b*b  

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
    sub al, [c]  ; al = a - c
    
    mov bl, 3
    imul bl  ; ax = (a-c)*3
    
    xor ebx, ebx
    mov bx, ax  ; bx = (a-c)*3
    xor eax, eax
    
    mov al, [b]
    mov dl, [b]
    
    imul dl  ; ax = b * b

    add ax, bx ; ax = (a-c)*3 + b*b
    
    cwde
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
