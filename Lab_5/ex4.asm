;Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel: fiecare ;element de pe pozitiile pare din D este suma elementelor de pe pozitiile corespunzatoare din S1 si ;S2, iar fiecare element de pe pozitiile impare are ca si valoare diferenta elementelor de pe ;pozitiile corespunzatoare din S1 si S2.
;Exemplu:

;S1: 1, 2, 3, 4
;S2: 5, 6, 7, 8
;D: 6, -4, 10, -4



bits 32 


global start        


extern exit, printf           
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data

    s db 1, 2, 3, 4
    l1 equ ($ - s)
    
    s1 db 5, 6, 7, 8
    l2 equ ($ - s1)
    
    d times l1 db 0
    
    print_b db "%d ", 0
   
segment code use32 class=code
start:
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov ecx, l1
    mov edi, 0
    mov esi, 0
    
    addBytes:
        
        mov al, [esi + s]
        mov bl, [esi + s1]
        
        test esi, 1
        jz par
        jmp impar
        
        
        par:
            add al, bl
        jmp end
            
            
        impar:
            sbb al, bl
        
        end:
            mov [d + edi], al
            xor eax, eax
            xor ebx, ebx
            inc esi
            inc edi

    loop addBytes
   
    mov ecx, l1
    mov esi, d
    
    writeBytes:
        push ecx
        
        lodsb 
        cbw
        cwde
        push eax
        push print_b
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    loop writeBytes

        
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program