; Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor de pe pozitiile multiplu de 3 din sirul S1 cu elementele sirului S2 in ordine inversa.
; Exemplu:

; S1: '+', '4', '2', 'a', '8', '4', 'X', '5'
; S2: 'a', '4', '5'
; D: '+', 'a', 'X', '5', '4', 'a'



bits 32 

global start        
extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    s1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
    leng_s1 equ ($ - s1)
    
    s2 db 'a', '4', '5'
    leng_s2 equ ($ - s2)
    
    r times leng_s1 + leng_s2 db 0 
    
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
    mov ecx, leng_s1 / 3 + 1
    
    incarcaBytes:
    
        mov al, [esi + s1]
        mov [edi + r], al
        
        inc edi
        add esi, 3
        
    loop incarcaBytes
    
    mov ecx, leng_s2
    xor esi, esi
    mov esi, leng_s2 - 1
    
    incarcaBytesInvers:
    
        mov al, [esi + s2]
        mov [edi + r], al
        
        inc edi
        dec esi
    
    loop incarcaBytesInvers
    
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