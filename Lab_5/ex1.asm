;Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat ;elementele din D sa reprezinte produsul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S.
;Exemplu:

;S: 1, 2, 3, 4
;D: 2, 6, 12

bits 32 
global start        


extern exit,printf               
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    s db 1, 2, 3, 4
    len equ ($ - s - 1)
    d resw 100
    print_frm db "%d ", 0
    
segment code use32 class=code
    start:
    
        mov esi, s
        mov edi, d
        mov ecx, len
        
        lodsb  ; al = s[0]
        mov bl, al ; bl = auxiliar
        
        loadOneByte:
            mov ah, bl  ; ah ia valoarea primului element din sir
            lodsb  ; al - ia valorea urmatorului element din sir
            mov bl, al 
            mul ah  ; ax = ah * al
            stosw
        loop loadOneByte
        
        xor eax, eax
        mov ebx, d
        mov ecx, len
        
        writeOneWord:
            push ecx
            
            lodsw
            push eax
            push print_frm
            call [printf]
            add esp, 2 * 4
            
            pop ecx
        loop writeOneWord
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
