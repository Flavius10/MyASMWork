;Given the words A and B, compute the doubleword C as follows:

;    the bits 0-4 of C are the same as the bits 11-15 of A
;    the bits 5-11 of C have the value 1
;    the bits 12-15 of C are the same as the bits 8-11 of B
;    the bits 16-31 of C are the same as the bits of A


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
    xor ebx, ebx  ; aici se va salva valoarea lui 
    xor ecx, ecx
    xor edx, edx
    
    mov ax, [A]
    and ax, 1111100000000000b   ; ultimi 5 biti din numarul ax sunt bitii lui ax
    mov cl, 11
    ror ax, cl  ; primii 5 biti a lui C sunt identici cu ultimii 5 biti a lui A
    or bx, ax ; bine
    
    or bx, 0000111111100000b ; the bits 5-11 of C have the value 1
                             ; 111111101110
                             ; 19876543210
    
    xor ax, ax
    
    mov ax, [B]
    or ax, 0000111100000000b
    xor cl, cl
    mov cl, 4
    rol ax, cl
    or bx, ax  ; the bits 12-15 of C are the same as the bits 8-11 of B
    
    
    xor eax, eax
    mov ax, [A]
    shl ax, 16
    or ebx, eax
    
    mov [C], ebx
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
