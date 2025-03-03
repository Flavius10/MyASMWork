;Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se obtina sirul D prin intercalarea ;elementelor celor doua siruri.
;Exemplu:

;S1: 1, 3, 5, 7
;S2: 2, 6, 9, 4
;D: 1, 2, 3, 6, 5, 9, 7, 4


bits 32 

global start        


extern exit, printf             
import exit msvcrt.dll   
import printf msvcrt.dll 
    
    s1 db 1, 3, 5, 7
    leng1 equ ($ - s1)
    
    s2 db 2, 6, 9, 4
    leng2 equ ($ - s2)
    
    d times leng1 + leng2 db 0
    
    print_b db "%d ", 0
  
segment data use32 class=data
    
segment code use32 class=code
    start:
    
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        
        xor esi, esi
        xor edi, edi
        mov ecx, leng1
        
        loadBytes:
            
            mov al, [esi + s1]
            mov bl, [esi + s2]
            
            mov [d + edi], al
            inc edi
            mov [d + edi], bl
            inc edi
            
            inc esi
            
        loop loadBytes
        
        mov ecx, leng1 + leng2
        xor esi, esi
        mov esi, d
        
        writeBytes:
            
            push ecx
            
            lodsb
            push eax
            push print_b
            call [printf]
            add esp, 2 * 4
            
            pop ecx
            
        loop writeBytes
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
