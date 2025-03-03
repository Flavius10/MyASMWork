;Se de cuvantul A si octetul B. Sa se obtina dublucuvantul C astfel:

;    bitii 0-3 ai lui C coincid cu bitii 6-9 ai lui A
;    bitii 4-5 ai lui C au valoarea 1
;    bitii 6-7 ai lui C coincid cu bitii 1-2 ai lui B
;    bitii 8-23 ai lui C coincid cu bitii lui A
;    bitii 24-31 ai lui C coincid cu bitii lui B

bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A dw 1001101010001010b
    B db 10001101b
    C db 0  
    
    print_frm db 'Rezultatul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx  ; aici se va salva C
    xor ecx, ecx 
    
    mov ax, [A]
    and ax, 0000001111000000b
    mov cl, 6
    ror ax, cl
    or bx, ax  ; bitii 0-3 ai lui C coincid cu bitii 6-9 ai lui A
    
    xor eax, eax  ; mov eax, 0
    xor ecx, ecx
    
    or bx, 0000000000110000b ; bitii 4-5 ai lui C au valoarea 1
    
    mov al, [B]
    and al, 00000110b
    shl eax, 5
    or ebx, eax ; bitii 6-7 ai lui C coincid cu bitii 1-2 ai lui B
    
    xor eax, eax
    
    mov ax, [A]
    shl eax, 8
    or ebx, eax ; bitii 8-23 ai lui C coincid cu bitii lui A
    
    xor eax, eax
    mov al, [B]
    shl eax, 24
    or ebx, eax ; bitii 24-31 ai lui C coincid cu bitii lui B
    
    xor eax, eax
    
    mov [C], ebx
    
    push    dword 0     
    call    [exit]
