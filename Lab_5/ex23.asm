; Se da un sir de octeti S. Sa se obtina in sirul D multimea elementelor din S.
; Exemplu:

; S: 1, 4, 2, 4, 8, 2, 1, 1
; D: 1, 4, 2, 8


bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    s db 1, 4, 2, 4, 8, 2, 1, 1
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
    
    xor esi, esi
    xor edi, edi
    mov ecx, leng
    
    outterloop:
    
        push ecx
        mov al, [esi + s]
        
        mov ecx, edi
        xor edx, edx
        jecxz adauga
        
        innerloop:
            
            mov bl, [edx + r]
            cmp al, bl
            je next
            
            inc edx
        
        loop innerloop
        
        adauga:
        mov [edi + r], al
        inc edi
        
        next:
            inc esi
        
        pop ecx
        
    loop outterloop
   
   
    xor esi, esi
    mov esi, r
    mov ecx, edi
    
    writeByte:
    
        push ecx
        
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
        
    
    loop writeByte
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
