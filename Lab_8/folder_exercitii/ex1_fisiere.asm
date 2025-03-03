; Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de vocale si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date. 
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

    name_file db "fisier.txt", 0
    mod_acces db "r", 0
    
    len equ 1000
    text times len db 0
    
    descriptor dd -1    
    print_frm db "%c", 0
    print_len db "%d", 0
   
segment code use32 class=code
start:

    push dword mod_acces
    push dword name_file
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
    xor ebx, ebx
    xor edx, edx
    
    scrie_biti:
    
        lodsb
        
        cmp al, 0
        je close_file
        
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
    
    jmp scrie_biti
    
    
    close_file:
    push dword [descriptor]
    call [fclose]
    add esp, 1 * 4
   
    finish:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
