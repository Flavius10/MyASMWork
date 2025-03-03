;Se da un sir de octeti S. Sa se construiasca sirul D1 ce contine elementele de pe pozitiile pare din ;S si sirul D2 ce contine elementele de pe pozitiile impare din S.
;Exemplu:

;S: 1, 5, 3, 8, 2, 9
;D1: 1, 3, 2
;D2: 5, 8, 9

bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data

    s1 db 1, 5, 3, 8, 2, 9
    leng1 equ ($ - s1)
    
    d times leng1 db 0
    d1 times leng1 db 0
    
    print_frm db "%d ", 0
    print_frm_enter db "", 10, 13, 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor esi, esi
    xor edi, edi
    
    mov ecx, leng1
    
    pozitiiPare:
        
        mov al, [esi + s1]
        test esi, 1
        jz pare
        
        impare:
            jmp next
            
        pare:
            mov [edi + d], al
            inc edi
            
        next:
            inc esi
        
    loop pozitiiPare
    
    xor esi, esi
    xor edi, edi
    mov ecx, leng1
    
    pozitiiImpare:
        
        mov al, [esi + s1]
        
        test esi, 1
        jnz impare1
        
        pare1:
            jmp next1
            
        impare1:
            mov [edi + d1], al
            inc edi
            
        next1:
            inc esi
        
    loop pozitiiImpare
    
    
    xor esi, esi
    mov esi, d
    mov ecx, leng1 / 2
    
    writeBytes:
        
        push ecx
        
        lodsb 
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeBytes
    
    push print_frm_enter
    call [printf]
    add esp, 4
    
    xor esi, esi
    mov esi, d1
    mov ecx, leng1 / 2
    
    writeBytes1:
        
        push ecx
        
        lodsb 
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeBytes1
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
