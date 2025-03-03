;Se da un sir de octeti S. Sa se construiasca sirul D astfel: sa se puna mai intai elementele de pe ;pozitiile pare din S iar apoi elementele de pe pozitiile impare din S.
;Exemplu:

;S: 1, 2, 3, 4, 5, 6, 7, 8
;D: 1, 3, 5, 7, 2, 4, 6, 8


bits 32 


global start        


extern exit, printf             
import exit msvcrt.dll   
import printf msvcrt.dll 
    
    s db 1, 2, 3, 4, 5, 6, 7, 8
    leng equ ($ - s)
    
    d times leng db 0
    
    print_b db "%d ", 0
  
segment data use32 class=data
    
segment code use32 class=code
    start:
    
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        
        mov ecx, leng
        mov esi, 0
        mov edi, 0
        
       loadBytesEvenPositions:
        
            mov al, [esi + s]
            
            test esi, 1
            jz addByte
            jmp incrementare
            
            addByte:
                mov [d + edi], al
                inc edi
                
            incrementare:
                xor eax, eax
                inc esi
           
        loop loadBytesEvenPositions
        
        mov ecx, leng
        xor esi, esi
        
        loadBytesOddPositions:
        
            mov al, [esi + s]
            
            test esi, 1
            jnz addByte1
            jmp incrementare1
            
            addByte1:
                mov [d + edi], al
                inc edi
                
            incrementare1:
                xor eax, eax
                inc esi
        
        loop loadBytesOddPositions

        xor esi, esi
        mov esi, d
        mov ecx, leng
        
        writeByte:
            push ecx
            
            lodsb
            push eax
            push print_b
            call [printf]
            add esp, 2 * 4
            
            pop ecx
            
        loop writeByte
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
