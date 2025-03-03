bits 32

global secventa        

extern exit, printf, scanf              
import exit msvcrt.dll  
import printf msvcrt.dll  
import scanf msvcrt.dll  

segment data use32 class=data
    
    litera db 0, 0

    cuvinte times 200 db 0, 0
    cuvant1 dd 0, 0      
    cuvant2 dd 0, 0  

    ascii_new_line db 0Ah   
    
    mesaj db "1 - Cuvantul este secventa/ 0 - Cuvantul nu este secventa: %d", 0
    
    format_citire db "%s"
    format_scriere db "%s", 0
    
    format_citire_caracter db "%c", 0
    format_scriere_caracter db "%c ", 0
    print_len db "%d ", 0
    
    len_cuvant_1 dd 0, 0
    len_cuvant_2 dd 0, 0

segment code use32 class=code
secventa:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor edi, edi
    xor esi, esi

    
; ; =========== citeste cuvintele litera cu litera ========
    ; mov edi, cuvinte

    ; citeste_litere_cuvant1:
    
        ; push litera
        ; push format_citire_caracter
        ; call [scanf]
        ; add esp, 2 * 4
        
        ; mov al, [litera]
        ; cmp al, [ascii_new_line]
        ; je formeaza_cuvinte
        
        ; mov [edi + ebx], al
        ; inc ebx
    
    ; jmp citeste_litere_cuvant1
    
    
; ; =============== formeaza cele doua cuvinte ==========
    ; formeaza_cuvinte:
    
    ; xor ebx, ebx
    ; xor edi, edi
    ; mov esi, cuvinte
    ; mov edi, cuvant1

; ; ============ salveaza primul cuvant =============
    ; salveaza_primul_cuvant:
    
        ; lodsb
        
        
        ; cmp al, " "
        ; je formeaza_al_doilea_cuvant
        
        ; inc ebx
        ; stosb
    
    ; jmp salveaza_primul_cuvant
    
; ;========== salveaza al doilea cuvant ==========
    ; formeaza_al_doilea_cuvant:
    ; sub ebx, 1
    ; mov [len_cuvant_1], ebx ; lungime_primul_cuvant
    
    ; xor edi, edi
    ; mov esi, cuvinte
    ; add esi, ebx
    ; xor ebx, ebx
    ; mov edi, cuvant2
    
    ; salveaza_al_doilea_cuvant:
        
        ; lodsb
        
        ; cmp al, " "
        ; je next_step
        
        ; cmp al, 0
        ; je next
        
        ; inc ebx
       
        ; stosb
        
        ; next_step:
        
    ; jmp salveaza_al_doilea_cuvant
    
    
; ; ======== verifica daca primul cuvant este secventa in al doilea ========
    ; next:
        
    ; mov [len_cuvant_2], ebx ; lungime_al_doilea_cuvant

    ; cmp edx, ebx
    ; jl return_0
    
    ; jmp return_1
    
    ; return_0:
    
    ; push 0
    ; push print_len
    ; call [printf]
    ; add esp, 2 * 4
    
    ; jmp finish
    
; ; ======= verificare efectiva daca e secventa =========
    ; return_1:
    
    ; xor ecx, ecx
    ; mov ecx, [len_cuvant_2]
    
    ; jecxz return_0
    
    ; ; curatam registrii
    ; xor edx, edx
    ; xor ebx, ebx
    
    ; xor edi, edi
    ; xor esi, esi
    
    ; mov edi, cuvant1
    ; mov esi, cuvant2
    
    ; ; verificare
    ; parcurge_cuvantul_2:
    
        ; push ecx
        
        ; lodsb
        ; mov bl, [edi + edx]
        
        ; cmp edx, [len_cuvant_1]
        ; je final
        
        ; cmp al, bl
        ; je verifica_celelalte
        
        ; jmp caz_negativ
        
        ; verifica_celelalte:
            ; inc edx
            ; jmp next_step1
            
        ; caz_negativ:
        ; add ecx, edx
        ; xor edx, edx
        
        ; next_step1:
        
        ; pop ecx
    
    ; loop parcurge_cuvantul_2
    
    ; jecxz return_0
    
    ; push ecx
    ; push print_len
    ; call [printf]
    ; add esp, 2 * 4
    
    ; final:
        
    ; push 1
    ; push print_len
    ; call [printf]
    ; add esp, 2 * 4
    

    mov esi, [esp + 8]
    mov edi, cuvant2

; ============ salveaza primul cuvant =============
    salveaza_al_doilea_cuvant:
    
        lodsb
        
        cmp al, 0
        je al_doilea_cuvant
        
        inc ebx
        
        stosb
    
    jmp salveaza_al_doilea_cuvant
    
    al_doilea_cuvant:
    
    mov [len_cuvant_2], ebx
    
    xor ebx, ebx
    mov esi, [esp + 4]
    mov edi, cuvant1

; ============ salveaza primul cuvant =============
    salveaza_primul_cuvant:
    
        lodsb
        
        cmp al, 0
        je next
        
        inc ebx
        
        stosb
    
    jmp salveaza_primul_cuvant
    
   next:
    
    mov edx, [len_cuvant_2]
    
    cmp edx, ebx
    jl return_0
    
    mov [len_cuvant_1], ebx ; lungime_al_doilea_cuvant
    
        
;======= verificare efectiva daca e secventa =========
     return_1:
    
    xor ecx, ecx
    mov ecx, edx
    
    cmp ecx, 0
    je return_0
    
    ; curatam registrii
    xor edx, edx
    mov edx, [len_cuvant_1]
    xor ebx, ebx
    
    xor edi, edi
    xor esi, esi
    
    mov edi, cuvant1
    mov esi, cuvant2
   
    ;verificare
    parcurge_cuvantul_2:
        
        push ecx
        push edx
          
        lodsb
        
        cmp al, [edi + ebx]
        jne caz_negativ
        
        inc ebx
            
        cmp ebx, edx
        je final_bun

        jmp urmatorul_pas
            
        caz_negativ:
            
            add ecx, ebx
            xor ebx, ebx
            
        urmatorul_pas:
        
        pop edx
        pop ecx
        
    loop parcurge_cuvantul_2
    
    
;======= cazul in care nu este secventa ==========

    return_0:
    
    mov eax, 0
    
    jmp finish
; =========== cazul in care este secventa ==============

    final_bun:
    
    pop edx
    pop ecx
    
    xor eax, eax
    mov eax, 1

    finish:
        ret 8
