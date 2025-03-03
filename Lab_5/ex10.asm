;Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor ;sirului S2 in ordine inversa cu elementele de pe pozitiile pare din sirul S1.
;Exemplu:

;S1: '+', '2', '2', 'b', '8', '6', 'X', '8'
;S2: 'a', '4', '5'
;D: '5', '4', 'a', '2','b', '6', '8'


bits 32 
global start        


extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data

    s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
    leng1 equ ($ - s1)
    
    s2 db 'a', '4', '5'
    leng2 equ ($ - s2)
    
    d times leng1 + leng2 db 0
    
    print_frm db "%c ", 0
    
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov esi, s2 + leng2 - 1
    mov edi, 0
    mov ecx, leng2
    
    scrieInversS2:
    
        mov al, [esi]
        dec esi
        
        mov [d + edi], al
        inc edi
    
    loop scrieInversS2
    
    mov ecx, leng1
    mov esi, 0
    xor eax, eax
    
    scriePozitiiPare:
    
        mov al, [esi + s1]
        
        test esi, 1
        jz par
        jmp incrementare
        
        par:
            mov [edi + d], al
            inc edi
            
        incrementare:
            xor eax, eax
            inc esi
    
    loop scriePozitiiPare
    
    mov esi, 0
    mov esi, d
    mov ecx, edi
    
    writeBytes:
        
        push ecx
        
        lodsb
        push eax
        push print_frm
        call [printf]
        
        add esp, 2 * 4
        
        pop ecx
    
    loop writeBytes
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
