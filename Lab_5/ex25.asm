; Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D ce contine toate elementele din S1 care nu apar in S2.
; Exemplu:

; S1: '+', '4', '2', 'a', '8', '4', 'X', '5'
; S2: 'a', '4', '5'
; D: '+', '2', '8', 'X'

bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    a db '+', '4', '2', 'a', '8', '4', 'X', '5'
    lenga equ ($ - a)
    
    b db 'a', '4', '5'
    lengb equ ($ - b)
    
    r times lenga + lengb db 0
    
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
    mov ecx, lenga
    
    outterLoop:
    
        push ecx
        
            mov al, [esi + a]
            
            mov ecx, lengb
            xor edx, edx
            jecxz adauga
            
            innerLoop:
            
                mov bl, [edx + b]
                cmp al, bl
                je next
                
                inc edx
            
            loop innerLoop
            
            adauga:
                mov [edi + r], al
                inc edi
            
            next:
                inc esi
        
        pop ecx
    
    loop outterLoop
    
    xor esi, esi
    mov esi, r
    mov ecx, edi
    
    writeByte:
    
        push ecx
        
        lodsb
        cbw
        cwde
        
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeByte
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program