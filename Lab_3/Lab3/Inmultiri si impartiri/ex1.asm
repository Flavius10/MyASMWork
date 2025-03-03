; c+(a*a-b+7)/(2+a), a-byte; b-doubleword; c-qword

bits 32 
global start        

extern exit, printf               
import exit msvcrt.dll 
import printf msvcrt.dll
   
segment data use32 class=data

    a db 10
    b dd 5
    c dq 7
    
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
    imul bl  ; ax = a * a
    cwde  ; eax = a * a
    
    sbb eax, [b]
    adc eax, 7  ; eax = (a*a-b+7)
    adc eax, [c]  ; eax = c + (a*a-b+7)
    
    mov edx, eax ; edx = c + (a*a-b+7)
    
    xor eax, eax
    mov al, [a]
    adc  al, 2
    
    cbw
    cwde ; eax = a + 2
    
    
    mov ebx, eax  ; ebx = a + 2
    xor eax, eax
    mov eax, edx  ; eax = c + (a*a-b+7)
    xor edx, edx
    cdq  ; convertim pe eax la quadword  edx:eax
    
    idiv ebx  ; eax = catul  edx = restul
    
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
