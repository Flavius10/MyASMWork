; Sa se citeasca de la tastatura un nume de fisier si un text. Sa se creeze un fisier cu numele dat in directorul curent si sa se scrie textul in acel fisier. Observatii: Numele de fisier este de maxim 30 de caractere. Textul este de maxim 120 de caractere. 

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
    descriptor dd -1
    
    len_nume equ 34
    nume_fisier times len_nume db 0, 0
    
    len_text equ 1000
    text times len_text db 0, 0
    
    caracter db 0
    
    format_string db "%s", 0
    format_int db "%d", 0
    format_caracter db "%c", 0
    
    extensie db ".txt", 0
    
    ascii_new_line db 0x0A
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push nume_fisier
    push format_string
    call [scanf]
    add esp, 2 * 4
    
    mov esi, nume_fisier
    
    lungime_nume:
    
        lodsb
        
        cmp al, 0
        je next_step
        
        inc ebx
    
    jmp lungime_nume
    
    next_step:
    
    mov edi, nume_fisier
    add edi, ebx
    mov esi, extensie
    
    adaugare_extensie:
        
        lodsb
        
        cmp al, 0
        je create_file
        
        stosb
        
    jmp adaugare_extensie
    
    create_file:
    
        push caracter
        push format_caracter
        call [scanf]
        add esp, 2 * 4
    
        push mod_acces
        push nume_fisier
        call [fopen]
        add esp, 2 * 4
        
        mov [descriptor], eax
        
        cmp eax, 0
        je final
        
        mov edi, text

        citire_text:
        
            push caracter
            push format_caracter
            call [scanf]
            add esp, 2 * 4
            
            mov al, [caracter]
            
            cmp al, [ascii_new_line]
            je adauga_text
            
            stosb
        
        jmp citire_text
        
        adauga_text:
            push text
            push dword [descriptor]
            call [fprintf]
            add esp, 2 * 4
            
        
        close_file:
        push dword [descriptor]
        call [fclose]
        add esp, 1 * 4
  
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
