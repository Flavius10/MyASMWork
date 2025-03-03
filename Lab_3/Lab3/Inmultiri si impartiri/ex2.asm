; 2/(a+b*c-9)+e-d; a,b,c-byte; d-doubleword; e-qword

bits 32 
global start        

extern exit, printf               
import exit msvcrt.dll 
import printf msvcrt.dll
   
segment data use32 class=data

    a db 10
    b dd 5
    c dq 7
    d dd 8
    e dq 10
    
    print_frm db 'Rezultatul este: %d', 0
    cat_frm db 'Catul este: %d', 10, 13, 0
    rest_frm db 'Restul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [b]
    imul byte [c] ; ax = b * c
    cwde
    
    sbb eax, 9  ; eax = b * c - 9
    
    mov edx, eax ; edx = b * c - 9
    xor eax, eax ; eax = 0
    
    mov al, [a]
    cbw
    cwde
    
    adc eax, edx ; eax = a+b*c-9
    cdq
    
    mov ebx, eax  ; ebx = a+b*c-9
    xor eax, eax
    mov eax, 2
    
    idiv ebx ; eax = catul edx = restul
    
    adc eax, [e]
    sbb eax, [d]
    
    push edx
    push eax
    push cat_frm
    call [printf]
    add esp, 8
    
    pop edx
    
    push edx
    push rest_frm
    call [printf]
    add esp, 8
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
