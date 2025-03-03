; Se dau octetul A si cuvantul B. Sa se obtina dublucuvantul C:

    ; bitii 0-7 ai lui C au valoarea 1
    ; bitii 8-11 ai lui C coincid cu bitii 4-7 ai lui A
    ; bitii 12-19 coincid cu bitii 2-9 ai lui B
    ; bitii 20-23 coincid cu bitii 0-3 ai lui A
    ; bitii 24-31 coincid cu octetului high din cuvantul B


bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data
    
    a db 10010101b 
    b dw 1011010101011010b
    
    c dd 0   ; 1011010101010101 0110100111111111
             ; 1011010101010101 0110100111111111
    
    print_frm db "Rezultatul este: %u", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx ; aici vom salva valoarea lui C
    xor edx, edx
    xor ecx, ecx
    
    or ebx, 11111111b
    
    ; bitii 8-11 ai lui C coincid cu bitii 4-7 ai lui A
    mov al, [a]
    and ax, 11110000b
    shl ax, 4
    or ebx, eax
    
    ; bitii 12-19 coincid cu bitii 2-9 ai lui B
    xor eax, eax
    mov ax, [b]
    and ax, 0000001111111100b
    shl eax, 10
    or ebx, eax
    
    ; bitii 20-23 coincid cu bitii 0-3 ai lui A
    xor eax, eax
    mov al, [a]
    and al, 00001111b
    shl eax, 20
    or ebx, eax
    
    ; bitii 24-31 coincid cu octetului high din cuvantul B
    
    xor eax, eax
    mov ax, [b]
    and ax, 1111111100000000b
    shl eax, 16
    or ebx, eax
    
    mov [c], ebx
    
    push ebx
    push print_frm
    call [printf]
    add esp, 2 * 4
   
    push    dword 0
    call    [exit]
