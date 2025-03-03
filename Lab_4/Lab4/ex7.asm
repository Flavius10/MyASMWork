;Se dau doua cuvinte A si B. Sa se obtina dublucuvantul C:

;   bitii 0-4 ai lui C au valoarea 1
;   bitii 5-11 ai lui C coincid cu bitii 0-6 ai lui A
;   bitii 16-31 ai lui C au valoarea 0000000001100101b
;   bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B 

bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A dw 1010110101000101b
    B dw 0 
    C dd 0
    
    print_frm db 'Rezultatul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx  ; aici se va salva C
    xor ecx, ecx 
    
    or ebx, 00011111b ; bitii 0-4 ai lui C au valoarea 1
    
    mov eax, [A]
    and eax, 0000000001111111b
    mov cl, 5
    shl eax, cl
    or ebx, eax ; bitii 5-11 ai lui C coincid cu bitii 0-6 ai lui A
    
    xor eax, eax
    
    mov eax, 0000000001100101b
    shl eax, 16
    or ebx, eax ; bitii 16-31 ai lui C au valoarea 0000000001100101b
    
    xor eax, eax
    xor ecx, ecx
    
    mov eax, [B]
    and eax, 0000111100000000b
    mov cl, 4
    shl eax, cl
    or ebx, eax ; bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B 
    
    mov [C], ebx
    
    push    dword 0     
    call    [exit]