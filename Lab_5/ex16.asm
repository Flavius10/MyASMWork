; Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor de pe pozitiile impare din S2 cu elementele de pe pozitiile pare din S1.
; Exemplu:

; S1: 'a', 'b', 'c', 'b', 'e', 'f'
; S2: '1', '2', '3', '4', '5'
; D: '1', '3', '5', 'b', 'b', 'f'


bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data

    s1 db 'a', 'b', 'c', 'b', 'e', 'f'
    lengs1 equ ($ - s1)
    
    s2 db '1', '2', '3', '4', '5'
    lengs2 equ ($ - s2)
    
    d times lengs1 + lengs2 db 0

    print_frm db "%c ", 0
    print_enter db "", 10, 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor edi, edi
    xor esi, esi
    mov ecx, lengs2
    
    pozitiiImpareS2:
    
        mov al, [esi + s2]
        inc ebx
        
        test ebx, 1
        jz par
        
        mov [edi + d], al
        inc edi
        
        par:
            inc esi
    
    loop pozitiiImpareS2
    
    xor esi, esi
    mov ecx, lengs1
    xor ebx, ebx
    
    pozitiiPareS1:
    
        mov al, [esi + s1]
        inc ebx
        
        test ebx, 1
        jnz impar
        
        mov [edi + d], al
        inc edi
        
        impar:
            inc esi
    
    loop pozitiiPareS1
    
    
    xor esi, esi
    mov esi, d
    mov ecx, edi
    
    writeArray:
    
        push ecx
        
            lodsb
            push eax
            push print_frm
            call [printf]
            add esp, 2 * 4
        
        pop ecx
    
    loop writeArray
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
