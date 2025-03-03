;Se dau doua cuvinte A si B. Sa se obtina dublucuvantul C:

;    bitii 0-6 ai lui C au valoarea 0
;    bitii 7-9 ai lui C coincid cu bitii 0-2 ai lui A
;    bitii 10-15 ai lui C coincid cu bitii 8-13 ai lui B
;    bitii 16-31 ai lui C au valoarea 1 

bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data

    A dw 1010101010011011b
    B dw 1001010101001010b
    
    C dd 0 ; 1111111111111111 0101010110000000
    
    print_frm db "Rezultatul este: %u", 0
    
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    ;bitii 7-9 ai lui C coincid cu bitii 0-2 ai lui A
    mov ax, [A]
    and ax, 0000000000000111b
    shl eax, 7
    or ebx, eax
    
    ;bitii 10-15 ai lui C coincid cu bitii 8-13 ai lui B
    xor eax, eax
    mov ax, [B]
    and ax, 0011111100000000b
    mov cl, 2
    shl eax, cl
    or ebx, eax
    
    ;bitii 16-31 ai lui C au valoarea 1
    xor eax, eax
    mov eax, 1111111111111111b
    shl eax, 16
    or ebx, eax
    
    mov [C], ebx
    
    push dword [C]
    push print_frm
    call [printf]
    add esp, 2 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
