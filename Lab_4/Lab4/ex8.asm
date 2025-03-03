;Se dau doua cuvinte A si B. Sa se obtina un octet C care are:

;    pe bitii 0-5, bitii 5-10 ai cuvantului A
;    pe bitii 6-7 bitii 1-2 ai cuvantului B.

;Sa se obtina dublucuvantul D care are :

;    pe bitii 8-15, bitii lui C
;    pe bitii 0-7, bitii 8-15 din B
;    pe bitii 24-31, bitii 0-7 din A
;    iar pe bitii 16-23, bitii 8-15 din A.

bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A dw 1001101010001010b
    B dw 1010110101000101b 
    C db 0  
    D dd 0
    
    print_frm db 'Rezultatul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx  ; aici se va salva C si mai incolo D
    xor ecx, ecx 
    
    mov ax, [A]
    and ax, 0000011111100000b
    mov cl, 5
    shr ax, cl
    or bx, ax ; pe bitii 0-5, bitii 5-10 ai cuvantului A
    
    xor eax, eax
    xor ecx, ecx
    
    mov ax, [B]
    and ax, 0000000000000110b
    mov cl, 5
    shl ax, 5
    or bx, ax
    
    mov [C], bx  ; 10010100
    
    xor eax, eax
    xor ecx, ecx
    xor ebx, ebx
    
    mov al, [C]
    shl eax, 8
    or ebx, eax  ;    pe bitii 8-15, bitii lui C
    
    xor eax, eax
    mov ax, [B]
    and ax, 1111111100000000b
    shr ax, 8
    or ebx, eax ;    pe bitii 0-7, bitii 8-15 din B
    
    xor eax, eax
    mov ax, [A]
    and ax, 0000000011111111b
    shl eax, 17
    or ebx, eax ;    pe bitii 24-31, bitii 0-7 din A
    
    xor eax, eax
    
    mov ax, [A]
    and ax, 1111111100000000b
    shl eax, 8
    or ebx, eax
    
    mov [D], ebx
    
    push    dword 0     
    call    [exit]
