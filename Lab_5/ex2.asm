;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate caracterele speciale ;(!@#$%^&*) din sirul S.
;Exemplu:

;S: '+', '4', '2', 'a', '@', '3', '$', '*'
;D: '@','$','*'

bits 32 
global start        


extern exit,printf               
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    s db '+', '4', '2', 'a', '@', '3', '$', '*'
    len equ ($ - s)
    d resw 100
    print_frm db "%c ", 0
    format_sir db "%s ", 0
    format_newline db '', 10, 13, 0
    
segment code use32 class=code
    start:
    
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        
        mov esi, s
        mov edi, d
        mov ecx, len
        
        loadOneByte:
        
            lodsb
            
            cmp al, "!"
            je special
            
            cmp al, "@"
            je special
            
            cmp al, "#"
            je special
            
            cmp al, "*"
            je special
            
            cmp al, "$"
            je special
            
            cmp al, '%'
            je special
    
            cmp al, '^'
            je special
            
            
            jmp notSpecial
            
            special:
                stosb
            notSpecial:
        
        loop loadOneByte
        
        mov ecx, len
        xor eax, eax
        
        writeAByte:
            push ecx
            
                lodsb
                push eax
                push print_frm
                call [printf]
                add esp, 2 * 4
            
            pop ecx
        
        loop writeAByte
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
