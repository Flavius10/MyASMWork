; Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura cuvinte pana cand se citeste de la tastatura caracterul '$'. Sa se scrie in fisier doar cuvintele care contin cel putin o cifra. 

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

    mod_acces db "w", 0
    descriptor dd -1, 0
    name_file db "ex30.txt", 0
    
    format_string db "%s", 0
    format_int db "%d", 0
    
    format_string_afisare db "%s ", 0
    cuvant times 30 db 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push dword mod_acces
    push dword name_file
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je final
    
    citeste_date:
    
        push cuvant
        push format_string
        call [scanf]
        add esp, 2 * 4
        
        cmp byte [cuvant], '$'
        je inchidere
        
        mov esi, cuvant
        cuvinte_cu_cifre:
        
            lodsb
            
            cmp al, 0
            je next
            
            cmp al, '0'
            jb next_character
            
            cmp al, '9'
            ja next_character
            
            jmp add_to_file
            
            next_character:
        
        jmp cuvinte_cu_cifre
        
        add_to_file:
        
            push cuvant
            push format_string_afisare
            push dword [descriptor]
            call [fprintf]
            add esp, 3 * 4
        
        next:
    
    jmp citeste_date
    
    inchidere:
    push dword [descriptor]
    call [fclose]
    add esp, 1 * 4
  
    final:
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
