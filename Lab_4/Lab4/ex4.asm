; Se da octetul A. Sa se obtina numarul intreg n reprezentat de bitii 2-4 ai lui A. Sa se obtina apoi in B octetul rezultat prin rotirea spre dreapta a lui A cu n pozitii. Sa se obtina dublucuvantul C:

;    bitii 8-15 ai lui C sunt 0
;    bitii 16-23 ai lui C coincid cu bitii lui B
;    bitii 24-31 ai lui C coincid cu bitii lui A
;    bitii 0-7 ai lui C sunt 1

bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A db 10111001b
    B db 0
    C dd 0
    n db 0
    
    print_frm db "Rezultatul este %d", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx 
    
    mov al, [A]
    and al, 00011100b
    shr al, 2
    or bl, al  ; Sa se obtina numarul intreg n reprezentat de bitii 2-4 ai lui A
    mov [n], bl  ; n = bitii 2-4 ai lui A
    
    xor eax, eax
    xor ebx, ebx
    
    mov cl, [n]
    mov al, [A]
    shr al, cl
    mov [B], al
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    
    mov eax, [C]
    and eax, 0000000011111111b  ; bitii 8-15 ai lui C sunt 0
    or ebx, eax  ; ebx are rezultatul la -> bitii 8-15 ai lui C sunt 0
    
    xor eax, eax
    mov al, [B]
    shl eax, 16
    or ebx, eax ; bitii 16-23 ai lui C coincid cu bitii lui B
    
    xor eax, eax
    mov al, [A]
    shl eax, 24
    or ebx, eax  ; bitii 24-31 ai lui C coincid cu bitii lui A
    
    xor eax, eax
    mov eax, ebx
    and eax, 11111111b
    or ebx, eax ; bitii 0-7 ai lui C sunt 1
    
    mov [C], ebx  ; rezolvat
    
    xor eax, eax
    mov eax, [C]
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program

