;Se dau doua siruri de octeti S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor din ;sirul S1 1uate de la stanga spre dreapta si a elementelor din sirul S2 luate de la dreapta spre stanga.
;Exemplu:

;S1: 1, 2, 3, 4
;S2: 5, 6, 7
;D: 1, 2, 3, 4, 7, 6, 5

bits 32 


global start        

extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    s1 db 1, 2, 3, 4
    len1 equ ($ - s1)
    
    s2 db 5, 6, 7
    len2 equ ($ - s2)
    
    d resb 100
    print_frm db "%d ", 0
  
segment code use32 class=code
start:
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov esi, s1
    mov edi, d
    mov ecx, len1
    
    writeFirstArray:
        push ecx
        
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    loop writeFirstArray
    
    xor eax, eax
    mov ecx, len2
    mov ebx, len2 - 1
    add esi, ebx
    std
    
    writeSecondArray:
        push ecx
        
            lodsb
            push eax
            push print_frm
            call [printf]
            add esp, 2 * 4
            
        pop ecx
    loop writeSecondArray
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program

