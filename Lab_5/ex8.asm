;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate literele mari din sirul S.
;Exemplu:

;S: 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'
;D: 'A', 'B', 'M'

bits 32 


global start        


extern exit, printf              
import exit msvcrt.dll   
import printf msvcrt.dll 
  
segment data use32 class=data

    s db 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'
    leng equ ($ - s)
    
    d times leng db 0
    
    print_frm db "%c ", 0
    
segment code use32 class=code
start:
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov esi, 0
    mov edi, 0
    
    mov ecx, leng
    
    loadLitereMari:
        
        mov al, [esi + s]
        
        cmp al, 'a'
        jae next
        cmp al, 'A'
        jb next
        
        mov [d + edi], al
        inc edi
        inc ebx
        
        next:
            inc esi
            
        
    loop loadLitereMari
    
    xor esi, esi
    mov esi, d
    mov ecx, ebx
    
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
