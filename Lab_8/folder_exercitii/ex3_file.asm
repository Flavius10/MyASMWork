; Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de cifre pare si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date. 
bits 32 
global start        

extern exit, printf, scanf, fopen, fclose, fread 
           
import exit msvcrt.dll   
import printf msvcrt.dll   
import scanf msvcrt.dll   
import fopen msvcrt.dll   
import fclose msvcrt.dll   
import fread msvcrt.dll

segment data use32 class=data
    
    file_name db "ex3.txt", 0
    
    descriptor dd -1, 0
    mod_acces db "r", 0
    
    len equ 1000
    text times len db 0, 0
    
    print_frm db "%c", 0
    print_len db "%d", 0
    scanf_frm db "%c", 0
    
segment code use32 class=code
start:
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push dword mod_acces
    push dword file_name
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je finish
    
    push dword [descriptor]
    push dword len
    push dword 1
    push dword text
    call [fread]
    add esp, 4 * 4
    
    mov esi, text
    
    scrie_biti:
        
        lodsb
        
        cmp al, 0
        je scrie
        
        cmp al, "0"
        je contorizare
        
        cmp al, "2"
        je contorizare
        
        cmp al, "4"
        je contorizare
        
        cmp al, "6"
        je contorizare
        
        cmp al, "8"
        je contorizare
        
        jmp final
        
        contorizare:
            inc ebx
            
        final:
        
    jmp scrie_biti
    
    scrie:
    push ebx
    push print_len
    call [printf]
    add esp, 2 * 4
    
    push dword [descriptor]
    call [fclose]
    add esp, 1 * 4
    
    finish:
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
