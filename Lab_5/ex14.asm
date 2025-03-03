; Se da un sir de octeti S. Sa se construiasca un sir D1 care sa contina toate numerele pozitive si un sir D2 care sa contina toate numerele negative din S.
; Exemplu:

; S: 1, 3, -2, -5, 3, -8, 5, 0
; D1: 1, 3, 3, 5, 0
; D2: -2, -5, -8


bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data

    s db 1, 3, -2, -5, 3, -8, 5, 0
    leng equ ($ - s)
    
    d times leng db 0
    d1 times leng db 0

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
    
    jecxz final
    
    numerelePozitive:
    
        mov al, [esi + s]
        cmp al, 0
        jnge next
        
        mov [edi + d], al
        inc edi
        
        next:
            inc esi
        
    loop numerelePozitive
    
    mov ecx, edi
    mov esi, d
    
    writeBytes:
    
        push ecx
        
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeBytes
    
    push print_enter
    call [printf]
    add esp, 1 * 4
    
    xor esi, esi
    xor edi, edi
    mov ecx, leng
    
    numereleNegative:
    
        mov al, [esi + s]
        
        cmp al, 0
        jge next1
        
        mov [edi + d1], al
        inc edi
        
        next1:
            inc esi
    
    loop numereleNegative
    
    mov ecx, edi
    mov esi, d1
    
    writeBytesNegative:
    
        push ecx
        
        lodsb
        cbw
        cwde
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeBytesNegative
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
