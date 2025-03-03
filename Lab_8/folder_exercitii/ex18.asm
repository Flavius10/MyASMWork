; Se da un fisier text care contine litere, spatii si puncte. Sa se citeasca continutul fisierului, sa se determine numarul de cuvinte si sa se afiseze pe ecran aceasta valoare. (Se considera cuvant orice secventa de litere separate prin spatiu sau punct) 

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

    mod_acces db "r", 0
    descriptor dd -1
    nume_fisier db "ex18.txt", 0
    
    len equ 1000
    text times len db 0
    
    format_string db "%s", 0
    format_int db "%d", 0
    format_caracter db "%c", 0
   
segment code use32 class=codes
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push mod_acces
    push nume_fisier
    call [fopen]
    add esp , 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je final
    
    push dword [descriptor]
    push dword len
    push dword 1
    push text
    call [fread]
    add esp, 4 * 4
    
    mov esi, text
    
    numarul_de_cuvinte:
    
        lodsb
        
        cmp al, 0
        je scrie_nr_de_cuvinte
        
        cmp al, " "
        je incrementare
        
        cmp al, "." 
        je incrementare
        
        jmp next
        
        incrementare:
        
            inc ebx
            
        next:
        
    jmp numarul_de_cuvinte
    
    scrie_nr_de_cuvinte:
        push ebx
        push format_int
        call [printf]
        add esp, 2 * 4
   
    push dword [descriptor]
    call [fclose]
    add esp, 1 * 4
   
    final:

    push    dword 0     
    call    [exit]         
    
    
