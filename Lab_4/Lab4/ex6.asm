;Se da cuvantul A. Sa se obtina numarul intreg n reprezentat de bitii 0-2 ai lui A. Sa se obtina apoi ;in B cuvântul rezultat prin rotirea spre dreapta (fara carry) a lui A cu n pozitii. Sa se obtina ;dublucuvantul C:

;   bitii 8-15 ai lui C sunt 0
;   bitii 16-23 ai lui C coincid cu bitii lui 2-9 ai lui B
;   bitii 24-31 ai lui C coincid cu bitii lui 7-14 ai lui A
;   bitii 0-7 ai lui C sunt 1


bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A dw 1010110101000101b
    B dw 0 
    C dd 0
    n dw 0
    
    print_frm db 'Rezultatul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx  ; aici se va salva C
    xor ecx, ecx 
    
    mov ax, [A]
    and ax, 0000000000000111b ; Sa se obtina numarul intreg n reprezentat de bitii 0-2 ai lui A
    mov [n], ax
    
    xor eax, eax
    mov ax, [A]
    mov cl, n
    ror ax, cl
    or bx, ax 
    mov [B], bx  ; Sa se obtina apoi in B cuvântul rezultat prin 
                 ; rotirea spre dreapta (fara carry) a lui A cu n pozitii.
    
    xor eax, eax
    xor ebx, ebx  ; bitii 8-15 ai lui C sunt 0
    
    mov ax, [B]
    and ax, 0000001111111100b
    shl eax, 14
    or ebx, eax  ; bitii 8-15 ai lui C sunt 0
    
    xor eax, eax
    mov ax, [A]
    and ax, 0111111110000000b
    shl eax, 17
    or ebx, eax  ; bitii 24-31 ai lui C coincid cu bitii lui 7-14 ai lui A
    
    or ebx, 0000000011111111b
    
    mov [C], ebx
    
    push    dword 0     
    call    [exit]

