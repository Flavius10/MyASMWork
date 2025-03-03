; Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura cuvinte si sa se scrie in fisier cuvintele citite pana cand se citeste de la tastatura caracterul '$'. 

bits 32  
global start        

 
extern exit, printf, scanf, fopen, fclose, fprintf, fread    
            
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll    
import fopen msvcrt.dll    
import fclose msvcrt.dll    
import fprintf msvcrt.dll    
import fread msvcrt.dll    

segment data use32 class=data

    mod_acess db "w", 0
    descriptor dd -1
    nume_fisier db "ex11.txt"
    
    len equ 1000
    text times len db 0
    
    cuvant times 30 db 0
    
    format_string db "%s", 0
    format_int db "%d", 0
    format_caracter db "%c", 0
    
    format_string_scriere db "%s ", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push mod_acess
    push nume_fisier
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je final
    
    mov edi, text
    
    citeste_text:
    
        push cuvant
        push format_string
        call [scanf]
        add esp, 2 * 4
        
        cmp byte [cuvant], '$'
        je adauga_text_to_file
        
        mov esi, cuvant
        adauga_text:
        
            lodsb
            
            cmp al, 0
            je next
            
            stosb
            
        jmp adauga_text
        
        next:
            
    jmp citeste_text
    
    adauga_text_to_file:
    push text
    push dword [descriptor]
    call [fprintf]
    add esp, 3 * 4
    
    close_file:
    push dword [descriptor]
    call [fclose]
    add esp, 1 * 4
    
    final:
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
