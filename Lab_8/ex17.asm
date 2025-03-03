;Sa se citeasca de la tastatura un numar in baza 10 si sa se afiseze valoarea acelui numar in baza 16 

bits 32 

global start        
extern exit, scanf, printf     
         
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll    

segment data use32 class=data

    numar db 0
    
    scanf_frm db "%d", 0
    print_frm db "%X", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push dword numar
    push scanf_frm
    call [scanf]
    add esp, 2 * 4
    
    push dword [numar]
    push print_frm
    call [printf]
    add esp, 2 * 4
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
