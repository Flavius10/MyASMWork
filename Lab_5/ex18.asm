; Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele impare si pozitive din cele 2 siruri.
; Exemplu:

; A: 2, 1, 3, -3
; B: 4, 5, -5, 7
; R: 1, 3, 5, 7


bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    a db 2, 1, 3, -3
    lenga equ ($ - a)
    
    b db 4, 5, -5, 7
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
    mov ecx, lenga
    
    numereDinA:
    
        mov al, [esi + a]
        test al, 1
        jz par
        
        cmp al, 0
        jl par
        
        mov [edi + r], al
        inc edi
        
        par:
            inc esi
        
    loop numereDinA
    
    xor esi, esi
    mov ecx, lengb
    
    numereDinB:
    
        mov al, [esi + b]
        test al, 1
        jz par1
        
        cmp al, 0
        jl par1
        
        mov [edi + r], al
        inc edi
        
        par1:
            inc esi
        
    loop numereDinB
    
    xor esi, esi
    mov esi, r
    mov ecx, lenga
    
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
