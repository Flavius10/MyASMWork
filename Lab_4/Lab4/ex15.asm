;Se dau cuvintele A si B. Se cere dublucuvantul C:

;    bitii 0-2 ai lui C au valoarea 0
;    bitii 3-5 ai lui C au valoarea 1
;    bitii 6-9 ai lui C coincid cu bitii 11-14 ai lui A
;    bitii 10-15 ai lui C coincid cu bitii 1-6 ai lui B
;    bitii 16-31 ai lui C au valoarea 1

bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data
    
    a dw 1001010101000110b 
    b dw 1011010101011010b
    
    c dd 0  ; 1111111111111111 1011010010111000
            ; 1111111111111111 1011010010111000
    
    print_frm db "Rezultatul este: %u", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx ; aici vom salva valoarea lui C
    xor edx, edx
    xor ecx, ecx
    
    ; bitii 3-5 ai lui C au valoarea 1
    or ebx, 00111000b
    
    ; bitii 6-9 ai lui C coincid cu bitii 11-14 ai lui A
    mov ax, [a]
    and ax, 0111100000000000b
    shr ax, 5
    or ebx, eax
    
    ; bitii 10-15 ai lui C coincid cu bitii 1-6 ai lui B
    xor eax, eax
    
    mov ax, [b]
    and ax, 0000000001111110b
    shl ax, 9
    or ebx, eax
    
    ; bitii 16-31 ai lui C au valoarea 1
    xor eax, eax
    mov ax, 1111111111111111b
    shl eax, 16
    or ebx, eax
    
    mov [c], ebx
    
    push ebx
    push print_frm
    call [printf]
    add esp, 2 * 4
    
    push    dword 0
    call    [exit]
