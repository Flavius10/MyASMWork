; Se dau cuvintele A si B. Se cere dublucuvantul C:

;    bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
;    bitii 4-8 ai lui C coincid cu bitii 0-4 ai lui A
;    bitii 9-15 ai lui C coincid cu bitii 6-12 ai lui A
;    bitii 16-31 ai lui C coincid cu bitii lui B


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
    xor ebx, ebx  ; aici se pune valoarea lui C
    xor ecx, ecx
    xor edx, edx
    
    mov ax, [B]
    and ax, 0000000111100000b
    mov cl, 5
    ror ax, cl
    or bx, ax  ; bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
    
    xor ax, ax
    mov ax, [A]
    and ax, 0000000000011111b
    xor cl, cl
    mov cl, 4
    rol ax, cl
    or bx, ax  ; bitii 4-8 ai lui C coincid cu bitii 0-4 ai lui A
    
    xor ax, ax
    xor cl, cl
    
    mov ax, [A]
    and ax, 0001111111000000b
    mov cl, 3
    rol ax, cl
    or bx, ax  ; bitii 9-15 ai lui C coincid cu bitii 6-12 ai lui A
    
    xor eax, eax
    mov ax, [B]
    shl ax, 16
    or ebx, eax  ; bitii 16-31 ai lui C coincid cu bitii lui B
    
    mov [C], ebx
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
