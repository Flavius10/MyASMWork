;Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor de ;pe pozitiile pare din S2 cu elementele de pe pozitiile impare din S1.
;Exemplu:

;S1: 'a', 'b', 'c', 'd', 'e', 'f'
;S2: '1', '2', '3', '4', '5'
;D: '2', '4','a','c','e'



bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data

    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    leng1 equ ($ - s1)
    
    s2 db '1', '2', '3', '4', '5'
    leng2 equ ($ - s2)
    
    d times leng1 + leng2 db 0
    print_frm db "%c "
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor esi, esi
    xor edi, edi
    
    mov ecx, leng2
    
    pozitiiPareS2:
    
        mov al, [esi + s2]
        test esi, 1
        jz pare1
        jnz impare1
        
        impare1:
           jmp next
           
        pare1: 
            mov [edi + d], al
            inc edi
            
        next:
            inc esi
    
    loop pozitiiPareS2
    
    xor esi, esi
    mov ecx, leng1
    
    pozitiiImpareS1:
    
        mov al, [esi + s1]
        test esi, 1
        jz pare
        jnz impare
        
        pare:
            jmp next1
            
        impare:
            mov [edi + d], al
            inc edi
            
        next1:
            inc esi
    
    loop pozitiiImpareS1
    
    xor esi, esi
    mov esi, d
    mov ecx , leng1 + leng2
    
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
