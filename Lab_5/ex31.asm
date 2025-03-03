; Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate caracterele cifre din sirul S.
; Exemplu:

; S: '+', '4', '2', 'a', '8', '4', 'X', '5'
; D: '4', '2', '8', '4', '5'



bits 32 

global start        
extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    s db '+', '4', '2', 'a', '8', '4', 'X', '5'
    leng equ ($ - s)
    
    r times leng db 0 
    
    print_frm db "%c ", 0
    print_enter db "", 10, 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor esi, esi
    xor edi, edi
    mov ecx, leng
    
    cifre:
    
        mov al, [esi + s]
        cmp al, '1'
        jb nu_e_cifra
        
        cmp al, '9'
        ja nu_e_cifra
        
        mov [edi + r], al
        inc edi
        
        nu_e_cifra:
            inc esi
    
    loop cifre
    
    mov ecx, edi
    xor esi, esi
    mov esi, r
    
    writeBytes:
    
        push ecx
        
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeBytes
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program