; Se da un sir de octeti S. Sa se determine maximul elementelor de pe pozitiile pare si minimul elementelor de pe pozitiile impare din S.
; Exemplu:

; S: 1, 4, 2, 3, 8, 4, 9, 5
; max_poz_pare: 9
; min_poz_impare: 3


bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll 
import printf msvcrt.dll  

segment data use32 class=data
    
    s db 1, 4, 2, 3, 8, 4, 9, 5
    leng equ ($ - s)
    
    max_pare db 0
    min_impare db 0    
    
    print_frm db "Maximul este: %d ", 0
    print_frm_minim db "Minimul este: %d ", 0
    print_enter db "", 10, 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
   xor esi, esi
   xor edi, edi
   mov ecx, leng / 2
   
   maximPare:
   
        mov al, [esi + s]
        
        cmp al, bl
        ja adauga_pare
        jmp next

        adauga_pare:
        mov bl, al
        
        next:
        add esi, 2
   
   loop maximPare
   
   mov [max_pare], bl
   
   xor esi, esi
   xor ebx, ebx
   mov bl, 11111111b
   mov esi, 1
   mov ecx, leng / 2
   
   minimImpare:
   
        mov al, [esi + s]
        cmp al, bl
        jb adauga_impare
        jmp next1
        
        adauga_impare:
         mov bl, al
        
        next1:
            add esi, 2
   
   loop minimImpare
   
   mov [min_impare], bl
   
   xor eax, eax
   mov al, [max_pare]
   
   push eax
   push print_frm
   call [printf]
   add esp, 2 * 4
   
   push print_enter
   call [printf]
   add esp, 1 * 4
   
   xor eax, eax
   mov al, [min_impare]
   
   push eax
   push print_frm_minim
   call [printf]
   add esp, 2 * 4
   
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program