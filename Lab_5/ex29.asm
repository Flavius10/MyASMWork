; Se da un sir de octeti S. Sa se construiasca sirul D ale carui elemente reprezinta suma fiecaror doi octeti consecutivi din sirul S.
; Exemplu:

; S: 1, 2, 3, 4, 5, 6
; D: 3, 5, 7, 9, 11



bits 32 

global start        
extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    s db 1, 2, 3, 4, 5, 6
    leng equ ($ - s)
    
    r times leng db 0 
    
    print_frm db "%d ", 0
    print_enter db "", 10, 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov ecx, leng - 1
    jecxz final
    xor esi, esi
    xor edi, edi
    
    loopBytes:
    
        mov al, [esi + s]
        mov bl, [esi + s + 1]
        
        add al, bl
        mov [edi + r], al
        
        inc esi
        inc edi
    
    loop loopBytes
    
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