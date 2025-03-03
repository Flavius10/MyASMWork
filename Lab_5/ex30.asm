; Se dau 2 siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul astfel incat fiecare element din D sa reprezinte suma dintre elementele de pe pozitiile corespunzatoare din S1 si S2.
; Exemplu:

; S1: 1, 3, 6, 2, 3, 2
; S2: 6, 3, 8, 1, 2, 5
; D: 7, 6, 14, 3, 5, 7



bits 32 

global start        
extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    s1 db 1, 3, 6, 2, 3, 2
    leng equ ($ - s1)
    
    s2 db 6, 3, 8, 1, 2, 5
    
    r times leng db 0 
    
    print_frm db "%d ", 0
    print_enter db "", 10, 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor esi, esi
    xor edi, edi
    mov ecx, leng
    
    jecxz final
    
    diferentaDintreNumere:
    
        mov al, [esi + s1]
        mov bl, [esi + s2]
        
        add al, bl
        mov [edi + r], al
        
        inc esi
        inc edi
    
    loop diferentaDintreNumere
    
    mov ecx, leng
    xor esi, esi
    mov esi, r
    
    writeBytes:
    
        push ecx
        
            lodsb
            push eax
            push print_frm
            call [printf]
            add esp, 2 * 4
        
        pop ecx
    
    loop writeBytes
    
    
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program