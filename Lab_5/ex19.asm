;Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele pare si ;negative din cele 2 siruri.
;Exemplu:

;A: 2, 1, 3, -3, -4, 2, -6
;B: 4, 5, -5, 7, -6, -2, 1
;R: -4, -6, -6, -2


bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data
    
    a db 2, 1, 3, -3, -4, 2, -6
    leng1 equ ($ - a)
    
    b db 4, 5, -5, 7, -6, -2, 1
    leng2 equ ($ - b)
    
    d times leng1 + leng2 db 0
    
    print_frm db "%d ", 0
    
   
segment code use32 class=code
start:
    
    xor ebx, ebx
    xor esi, esi
    xor edi, edi
    
    mov ecx, leng1
    
    saveNegativeNumbersA:
    
        mov al, [esi + a]
        
        cmp al, 0
        
        jl saveNegative
        jmp next
        
        saveNegative:
            test al, 1
            jz saveEven
            jmp next
            
            
        saveEven:
            mov [edi + d], al
            inc ebx
            inc edi
            jmp next
        
        next:
            inc esi
    loop saveNegativeNumbersA
    
    mov ecx, leng2
    xor esi, esi
    
    saveNegativeNumbersB:
    
        mov al, [esi + b]
        
        cmp al, 0
        
        jl saveNegative1
        jmp next1
        
        saveNegative1:
            test al, 1
            jz saveEven1
            jmp next1
            
            
        saveEven1:
            mov [edi + d], al
            inc ebx
            inc edi
            jmp next1
        
        next1:
            inc esi
    loop saveNegativeNumbersB
    
    xor esi, esi
    mov esi, d
    mov ecx, ebx
    
    jecxz final
    
    writeBytes:
    
        push ecx
        
        lodsb
        cbw
        cwde
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeBytes
    
    
    
   final:
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
