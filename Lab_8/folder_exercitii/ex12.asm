; Sa se citeasca de la tastatura un nume de fisier si un text. Sa se creeze un fisier cu numele dat in directorul curent si sa se scrie textul in acel fisier. Observatii: Numele de fisier este de maxim 30 de caractere. Textul este de maxim 120 de caractere. 

bits 32 
global start        

extern exit, printf, scanf, fopen, fclose, fread, fprintf             
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll    
import fopen msvcrt.dll    
import fclose msvcrt.dll    
import fread msvcrt.dll    
import fwrite msvcrt.dll   
import fprintf msvcrt.dll    

segment data use32 class=data

    mod_acces db "w", 0
    descriptor dd -1
    
    len equ 120
    text times len db 0, 0
    name_file times 35 db 0, 0
    
    print_frm db "%c", 0
    print_len db "%d", 0
    scan_frm db "%c", 0
    
    extensie_nume db ".", "t", "x", "t", 0
    
    caracter dd 0
    
    ascii_new_line_code db 0x0A, 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov edi, text
    
    citeste_textul:
    
        push dword caracter
        push dword scan_frm
        call [scanf]
        add esp, 2 * 4
        
        mov al, [caracter]
        
        cmp al, [ascii_new_line_code]
        je continuare
        
        mov [edi + ebx], al
        
        inc ebx
    
    jmp citeste_textul
    
    continuare:
    
    mov edi, name_file
    xor ebx, ebx
    
    salveaza_nume_fisier:
    
        push dword caracter
        push dword scan_frm
        call [scanf]
        add esp, 2 * 4
        
        mov al, [caracter]
        
        cmp al, [ascii_new_line_code]
        je extensie
        
        mov [edi + ebx], al
        
        inc ebx
    
    jmp salveaza_nume_fisier
    
    extensie:
    
    mov esi, extensie_nume
    mov edi, name_file
    add edi, ebx
    
    adauga_extensie:
        
        lodsb
        
        cmp al, 0
        je fisiere
        
        stosb
    
    jmp adauga_extensie
    
    fisiere:
    
    xor eax, eax
    push dword mod_acces
    push dword name_file
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je iesire
    
    push dword text
    push dword [descriptor]
    call [fprintf]
    add esp, 2 * 4
    
    
    push dword [descriptor]
    call [fclose]
    add esp, 2 * 4
    
    iesire:
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
