; Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina elementele lui B in ordine inversa urmate de elementele in ordine inversa ale lui A.
; Exemplu:

; A: 2, 1, -3, 0
; B: 4, 5, 7, 6, 2, 1
; R: 1, 2, 6, 7, 5, 4, 0, -3, 1, 2


bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    a db 2, 1, -3, 0
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
    xor edi, edi
    mov esi, lengb - 1
    mov ecx, lengb
    
    loopB:
    
        mov al, [esi + b]
        mov [edi + r], al
        
        inc edi
        dec esi
    
    loop loopB
    
    xor esi, esi
    mov esi, lenga - 1
    mov ecx, lenga
    
    loopA:
        
        mov al, [esi + a]
        mov [edi + r], al
        
        inc edi
        dec esi
    
    loop loopA
    
    mov ecx, lengb + lenga
    xor esi, esi
    mov esi, r
    
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
