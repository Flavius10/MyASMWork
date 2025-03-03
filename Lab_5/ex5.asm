;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate literele mici din sirul S.
;Exemplu:

;S: 'a', 'A', 'b', 'B', '2', '%', 'x'
;D: 'a', 'b', 'x'


bits 32 


global start        


extern exit, printf               
import exit msvcrt.dll   
import printf msvcrt.dll   

segment data use32 class=data
    
    s db 'a', 'A', 'b', 'B', '2', '%', 'x's
    leng equ ($ - s)
    
    d times leng db 0
    
    print_b db "%c ", 0
   
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov esi, 0
    mov edi, 0
    mov ecx, leng
    
    loadBytes:
        
        mov al, [esi + s]
        cmp al, 'a'
        jb incrementare
        cmp al, 'z'
        ja incrementare
        
        mov [d + edi], al
        inc ebx
        inc edi
        
        incrementare:
            xor eax, eax
            inc esi
    
    loop loadBytes
    
    mov ecx, ebx
    xor eax, eax
    xor esi, esi
    mov esi, d
    
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
