; Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat elementele din D sa reprezinte catul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S.
; Exemplu:

; S: 1, 6, 3, 1
; D: 0, 2, 3




bits 32 

global start        
extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    s db 1, 6, 3, 1
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
    xor esi, esi
    xor edi, edi
    
    repertaLoop:
    
        xor eax, eax
        mov al, [esi + s]
        
        mov bl, [esi + s + 1]
        div bl
        
        mov dl, al
        xor eax, eax
        mov al, dl
        
        mov [edi + r], al
        
        inc esi
        inc edi
    
    loop repertaLoop
    
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