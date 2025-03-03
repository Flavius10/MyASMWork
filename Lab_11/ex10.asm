; Se citesc mai multe siruri de caractere. Sa se determine daca primul apare ca subsecventa in fiecare din celelalte si sa se dea un mesaj corespunzator.

; Planul de rezolvare:
; -Citesc primul cuvant si il salvez intr-un registru, mai apoi citesc celelalte cuvinte si verific pentru fiecare daca primul cuvant(sir de caractere) se afla ca si subsecventa in celelealte siruri de caractere
; -Daca se afla ca si subsecventa in celelalte siruri de caractere o sa incrementez un registru(ei fiind comuni celor doua module) si totodata numar cand citesc cate un cuvant ca sa vad daca la final cele doua numere vor fi egale

bits 32 
global start        

extern exit, printf, scanf          
import exit msvcrt.dll    
import printf msvcrt.dll   
import scanf msvcrt.dll   

extern secventa
 
segment data use32 class=data

    format_citire db "%s", 0
    format_citire_caractere db "%c", 0
    format_scriere_caractere db "%c ", 0
    mesaj_pozitiv db "Toate sirurile de caractere au ca si subsecventa primul sir de caractere", 0
    mesaj_negativ db "Nu toate sirurile de caractere au ca si subsecventa primul sir de caractere",0
    
    format_introducere db "Introduceti mai multe siruri de carctere: ", 0
    print_frm db "%s ", 0
    print_len db "%d ", 0
    
    primul_cuvant times 100 db 0, 0 ; cuvantul citit la inceput
    cuvinte times 1000 db 0, 0 ; sirul de cuvinte pe care le vom citi si le vom verifica daca primul cuvant este o subsecventa a fiecarui cuvant in parte
    celalalt_cuvant times 100 db 0, 0
    litera db 0, 0
    
    cnt dd 0, 0
    suma dd 0, 0
    ascii_new_line db 0x0A
    
segment code use32 class=code
start:

; ====== curatam toti registrii =======

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor esi, esi
    xor edi, edi
    
; ====== afisam mesajul de introducere a cuvintelor ======
    push dword format_introducere
    call [printf]
    add esp, 1 * 4
    
; ========= citim toate caracterele =============
    mov edi, cuvinte
    
    citeste_caracterele:
    
        push dword litera
        push dword format_citire_caractere
        call [scanf]
        add esp, 2 * 4
        
        mov al, [litera]
        cmp al, [ascii_new_line]
        je next
        
        stosb
    
    jmp citeste_caracterele
    
    next:
    
; ========= separam primul cuvant de restul caracterelor ===========
    
    ; adaugam la final un space pentru a putea delimita ultimul cuvant
    add edi, 1
    mov al, " "
    mov [edi], al
    
    ; separam primul cuvant
    xor edi, edi
    mov edi, primul_cuvant
    mov esi, cuvinte
    
    separa_primul_cuvant:
        
        lodsb
        
        cmp al, " "
        je restul_cuvintelor
        
        inc ebx
        
        stosb 
    
    jmp separa_primul_cuvant
    
    ; trecem prin fiecare cuvant in parte
    restul_cuvintelor:
    
; =========== separam toate celelalte cuvinte pe rand ==========
    
    ; numerotam primul cuvant
    mov edx, [cnt]
    inc edx
    mov [cnt], edx
    
    xor esi, esi
    xor edi, edi
    xor eax, eax
    add ebx, 1 ; adaugam 1 ca sa sarim peste spatiul dintre primul cuvant si restul cuvintelor
    mov esi, cuvinte
    add esi, ebx
    mov edi, celalalt_cuvant
    
    xor ebx, ebx
    
    scrie_restul_cuvintelor:
    
        lodsb
        
        cmp al, " "
        je verifica_cuvinte
        
        cmp al, [ascii_new_line]
        je mesaj_final
        
        stosb
        jmp next_character
        
        verifica_cuvinte:
        ; ordinea pe stiva
        ; adresa retur
        ; primul_cuvant
        ; celalalt_cuvant
        
        pusha
        
        push dword celalalt_cuvant
        push dword primul_cuvant
        call secventa
        
        mov ebx, [suma]
        add ebx, eax
        mov [suma], ebx
        
        popa
        
        mov ebx, [suma]
        
       ; numerotam cuvintele (fara primul pe care l-am numerotat separat)
        mov edx, [cnt]
        inc edx
        mov [cnt], edx
        
        mov edi, celalalt_cuvant
        
        next_character:
    
    jmp scrie_restul_cuvintelor
    
    
; ========== afisam mesajul cerintei ============
    
    mesaj_final:

    mov [cnt], edx
    
    mov edx, [cnt]
    add ebx, 1
    
    cmp edx, ebx
    je mesaj_pozitiv_
    
    jmp mesaj_negativ_
    
    
    mesaj_pozitiv_:
    
    push mesaj_pozitiv
    call [printf]
    add esp, 1 * 4
    
    jmp final
    
    mesaj_negativ_:
    
    push mesaj_negativ
    call [printf]
    add esp, 1 * 4
    
    final:
        push    dword 0      
        call    [exit]       
