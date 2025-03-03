;Se da cuvantul A. Sa se obtina numarul intreg n reprezentat de bitii 0-2 ai lui A. Sa se obtina apoi ;in B cuvântul rezultat prin rotirea spre dreapta (fara carry) a lui A cu n pozitii. Sa se obtina ;dublucuvantul C:

;    bitii 8-15 ai lui C sunt 0
;    bitii 16-23 ai lui C coincid cu bitii lui 2-9 ai lui B
;    bitii 24-31 ai lui C coincid cu bitii lui 7-14 ai lui A
;    bitii 0-7 ai lui C sunt 1



bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A dw 0111011101010111b
    B dw 1001101110111110b
    C dd 0
    
    print_frm db "Rezultatul este %d", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx 
    
    mov ax, [A]
    and ax, 0111000000000000b
    mov cl, 12
    ror ax, cl
    or bx, ax  ;   bitii 0-2 ai lui C coincid cu bitii 12-14 ai lui A
    
    xor ax, ax
    xor cl, cl
    
    mov ax, [B]
    and ax, 0000000000111111b
    mov cl, 3
    rol ax, cl
    or bx, ax  ; bitii 3-8 ai lui C coincid cu bitii 0-5 ai lui B
    
    xor ax, ax
    xor cl, cl
    
    mov ax, [A]
    and ax, 0000001111111000b
    mov cl, 6
    rol ax, cl
    or bx, ax  ; bitii 9-15 ai lui C coincid cu bitii 3-9 ai lui A
    
    xor eax, eax
    mov ax, [A]
    shl ax, 16
    or ebx, eax  ; bitii 16-31 ai lui C coincid cu bitii lui A
    
    mov [C], ebx
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
