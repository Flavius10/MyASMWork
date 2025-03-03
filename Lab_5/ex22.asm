; Se dau 2 siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel incat fiecare element din D sa reprezinte minumul dintre elementele de pe pozitiile corespunzatoare din S1 si S2.
; Exemplu:

; S1: 1, 3, 6, 2, 3, 7
; S2: 6, 3, 8, 1, 2, 5
; D: 1, 3, 6, 1, 2, 5

bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    a db 1, 3, 6, 2, 3, 7
    leng equ ($ - a)
    
    b db 6, 3, 8, 1, 2, 5
    
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
    
    rezolvaDeodata:
        
        mov al, [esi + a]
        mov dl, [ebx + b]
        
        cmp al, dl
        jl al_mai_mic
        
        mov [edi + r], dl
        jmp incrementare
        
        al_mai_mic:
            mov [edi + r], al
        
        incrementare:
            inc esi
            inc edi
            inc ebx
            
    loop rezolvaDeodata
    
    xor esi, esi
    mov ecx, edi
    mov esi, r
    
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
