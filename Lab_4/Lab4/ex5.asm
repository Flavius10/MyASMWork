;Se dau octetii A si B. Sa se obtina dublucuvantul C:

;    bitii 16-31 ai lui C sunt 1
;    bitii 0-3 ai lui C coincid cu bitii 3-6 ai lui B
;    bitii 4-7 ai lui C au valoarea 0
;    bitii 8-10 ai lui C au valoarea 110
;    bitii 11-15 ai lui C coincid cu bitii 0-4 ai lui A 

bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A db 10111001b
    B db 10010101b
    C dd 0
    n db 0
    
    print_frm db "Rezultatul este %d", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx 
    
    mov ax, 1111111111111111b
    shl ax, 16
    or ebx, eax  ; bitii 16-31 ai lui C sunt 1
    
    xor eax, eax
    mov al, [B]
    shr al, 3
    or ebx, eax  ; bitii 0-3 ai lui C coincid cu bitii 3-6 ai lui B
    
    xor eax, eax
    mov eax, ebx
    and eax, 00001111b
    or ebx, eax  ; bitii 4-7 ai lui C au valoarea 0
    
    xor eax, eax
    mov eax, 00000110b
    shl eax, 8
    or ebx, eax  ; bitii 8-10 ai lui C au valoarea 110
    
    xor eax, eax
    mov eax, [A]
    and eax, 0000000000011111b
    mov cl, 11
    shl eax, cl
    or ebx, eax  ; bitii 11-15 ai lui C coincid cu bitii 0-4 ai lui A 
    
    mov [C], ebx
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program

