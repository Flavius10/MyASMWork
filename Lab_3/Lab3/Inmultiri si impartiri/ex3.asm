;(8-a*b*100+c)/d+x; a,b,d-byte; c-doubleword; x-qword

bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll   
import printf msvcrt.dll   

segment data use32 class=data

    a db 10
    b db 5
    d db 19
    c dd 20
    x dq 3
    
    print_frm db 'Rezultatul este: %d', 10, 13, 0
    cat_frm db 'Catul este: %d', 13, 10, 0
    rest_frm db 'Restul este: %d', 0
    
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    imul byte [b]  ; ax = a * b
    
    cwde  ; eax = ax = a * b
    
    mov ebx, eax  ; ebx = eax = a * b
    xor eax, eax
    
    mov eax, 100
    imul ebx  ; edx:eax = a * b * 100
    xor ebx, ebx
    
    mov ebx, eax  ; edx = a * b * 100
    adc ebx, [c]
    
    xor eax, eax
    mov eax, ebx  ; eax = a * b * 100 + c
    
    xor ebx, ebx  ; ebx = 0
    
    add ebx, 8
    sbb ebx, eax  ; ebx = 8 - a * b * 100 + c
    mov eax, ebx
    
    mov edx, eax  ; edx = 8 - a * b * 100 + c
    xor eax, eax
    mov al, [d]
    cbw
    cwde  ; eax = d
    
    mov ecx, eax
    mov eax, edx  ; eax = 8 - a * b * 100 + c
    mov edx, ecx  ; edx = d
    mov ebx, edx
    xor edx, edx
    
    cdq
    
    idiv ebx
    
    sbb eax, [x]
    
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
