; Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina elementele lui B in ordine inversa urmate de elementele impare ale lui A.
; Exemplu:

; A: 2, 1, 3, 3, 4, 2, 6
; B: 4, 5, 7, 6, 2, 1
; R: 1, 2, 6, 7, 5, 4, 1, 3, 3

bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data

    a db 2, 1, 3, 3, 4, 2, 6
    lenga equ ($ - a)
    
    b db 4, 5, 7, 6, 2, 1
    lengb equ ($ - b)
    
    r times lenga + lengb db 0 

    print_frm db "%d ", 0
    print_enter db "", 10, 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor esi, esi
    mov esi, lengb - 1
    xor edi, edi
    mov ecx, lengb
    
    jecxz final
    
    numereleDinBInvers:
        
        mov al, [esi + b]
        mov [edi + r], al
        
        dec esi
        inc edi
        
    loop numereleDinBInvers
    
    xor esi, esi
    mov ecx, lenga - 1
    
    numereleImpareA:
        
        mov al, [esi + a]
        
        test al, 1
        jz par
            mov [edi + r], al
            inc edi
        
        par:
            inc esi
        
    loop numereleImpareA
    
    xor esi, esi
    mov esi, r
    mov ecx, edi
    
    writeR:
    
        push ecx
        
            lodsb
            push eax
            push print_frm
            call [printf]
            add esp, 2 * 4
        
        pop ecx
    loop writeR
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
