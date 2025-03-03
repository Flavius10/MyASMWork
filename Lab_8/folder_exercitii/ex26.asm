; Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura cuvinte pana cand se citeste de la tastatura caracterul '$'. Sa se scrie in fisier doar cuvintele care contin cel putin o litera mare (uppercase). 

bits 32 
global start        

extern exit, printf, scanf, fclose, fopen, fread, fprintf             
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll    
import fclose msvcrt.dll    
import fopen msvcrt.dll    
import fread msvcrt.dll    
import fprintf msvcrt.dll    

segment data use32 class=data

    descriptor dd -1
    file_name db "file_name.txt", 0
    mod_acces db "a", 0
    
    cuvant times 30 db 0
    
    format_string db "%s", 0
    format_int db "%d", 0
    format_string_afisare db "%s ", 0
    
    print_c db "%c ", 0
    
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
    je final
    
    cld
    
    citeste_cuvinte:
    
        push cuvant
        push format_string
        call [scanf]
        add esp, 2 * 4
        
        cmp byte [cuvant], '$'
        je inchidere
        
        mov esi, cuvant
        
        cauta_litera_mare:
            
            lodsb
            
            cmp al, 0
            je next
            
            cmp al, 'A'
            jb next_character
            
            cmp al, 'Z'
            ja next_character
            
            jmp add_to_file
            
            next_character:
            
        
        jmp cauta_litera_mare
        
        add_to_file:
            
            push cuvant
            push format_string_afisare
            push dword [descriptor]
            call [fprintf]
            add esp, 3 * 4
        
        next:
    
    jmp citeste_cuvinte
    
    
   inchidere:
   
   push dword [descriptor]
   call [fclose]
   add esp, 1 * 4
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
