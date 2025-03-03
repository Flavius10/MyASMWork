;Se da dublucuvantul A. Sa se obtina numarul intreg n reprezentat de bitii 14-17 ai lui A. Sa se obtina apoi in B dublucuvantul rezultat prin rotirea spre stanga a lui A cu n pozitii. Sa se obtina apoi octet C astfel:

;    bitii 0-5 ai lui C coincid cu bitii 1-6 ai lui B
;    bitii 6-7 ai lui C coincid cu bitii 17-18 ai lui B

bits 32 
global start        

extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data

    A dd 10101010101001010010100101001010b
    ;                  111100000000000000b
    n db 0
    B dd 0
    C db 0
    
    print_frm db "Rezultatul este: %u", 0
    
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov eax, [A]
    and eax, 00000000000000111100000000000000b
    shr eax, 14
    mov [n], al
    
    xor eax, eax
    mov eax, [A]
    mov cl, [n]
    shl eax, cl
    mov [B], eax
    
    xor eax, eax
    mov eax, [B]
    and al, 01111110b
    shr al, 1
    or bl, al
    
    xor eax, eax
    mov eax, [B]
    and eax, 1100000000000000000b
    shr eax, 11
    or bl, al
    
    mov [C], bl
    xor eax, eax
    mov al, [C]
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
 