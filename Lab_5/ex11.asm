;Se da un sir de octeti S. Sa se obtina sirul D1 ce contine toate numerele pare din S si sirul D2 ce ;contine toate numerele impare din S.
;Exemplu:

;S: 1, 5, 3, 8, 2, 9
;D1: 8, 2
;D2: 1, 5, 3, 9


bits 32 
global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data

    s db 1, 5, 3, 8, 2, 9
    leng1 equ ($ - s)
    
    d times leng1 db 0
    d1 times leng1 db 0
    
    print_frm db "%d ", 0
    print_frm_enter db "", 10, 13, 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor esi, esi
    xor edi, edi
    mov ecx, leng1
    
    numerePare:
        
        mov al, [esi + s]
        test al, 1
        jz par
        jmp impar
        
        par:
            mov [edi + d], al
            inc edi
            jmp next
            
        impar:
            mov [ebx + d1], al
            inc ebx
        
        next:
            inc esi
        
    loop numerePare
    
    mov esi, 0
    mov esi, d
    mov ecx, edi
    
    writeBytes:
    
        push ecx
        
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
        
    loop writeBytes
    
    push print_frm_enter
    call [printf]
    add esp, 4
    
    mov esi, 0
    mov esi, d1
    mov ecx, ebx
    
    writeBytes1:
    
        push ecx
        
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
        
    loop writeBytes1
    
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
