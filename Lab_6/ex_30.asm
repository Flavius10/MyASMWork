;Se da un sir de cuvinte. Sa se construiasca doua siruri de octeti, s1 si s2, astfel: pentru fiecare ;cuvant,

;daca numarul de biti 1 din octetul high al cuvantului este mai mare decat numarul de biti 1 din ;    octetul low, atunci s1 va contine octetul high, iar s2 octetul low al cuvantului
;daca numarul de biti 1 din cei doi octeti ai cuvantului sunt egali, atunci s1 va contine numarul de ; biti 1 din octet, iar s2 valoarea 0
;altfel, s1 va contine octetul low, iar s2 octetul high al cuvantului.

; octet high > octet low => s1 - octetul high, s2 - octetul low
; octet low == octet low => s1 - numarul de biti 1, s2 - 0
; octet high < octet low => s1 - octet low , s2 - octetul high

bits 32
global start      

extern exit, printf         
import exit msvcrt.dll    
import printf msvcrt.dll   
 
segment data use32 class=data

    s dw 1432h, 8675h, 0ADBCh, 2F0Dh
;         2 3    3 5    5  5    5 3
    leng equ ($ - s) / 2
    leng_bytes equ leng * 2
    
    s1 times leng_bytes db 0
    s2 times leng_bytes db 0
    
    d times leng_bytes db 0

    print_frm db "%d ", 0
    print_enter db "", 10, 0
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    cld
    mov esi, s
    mov edi, 0
    mov ecx, leng
    
    storeBytes:
        
        mov ebx, 0
        lodsb
        
        count_1:
            test al, 1
            jz skip
            
            inc bh
            
            skip:
            shr al, 1
            cmp al, 0
            je second
        jmp count_1
        
        second:
            lodsb 
            
            count_1_second:
                test al, 1
                jz skip_second
                
                inc bl
                
                skip_second:
                shr al, 1
                cmp al, 0
                je final
            jmp count_1_second
            
            
        final:
        cmp bl, bh
        je add_equal
        jb add_below
        ja add_above
        
        add_equal:
            mov [edi + s1], bl
            inc edi
             
            mov byte [edx + s2], 0
            inc edx
            
            jmp finish
            
        add_below:
            mov [edi + s1], bh
            inc edi
             
            mov [edx + s2], bl
            inc edx
            
            jmp finish
            
        add_above:
            mov [edi + s1], bl
            inc edi
             
            mov [edx + s2], bh
            inc edx
            
            jmp finish
            
        
        finish:
    loop storeBytes
    
    mov esi, s1
    mov ecx, leng
    jecxz final_program
    
    writeByte1:
        
        push ecx
        
        mov eax, 0
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
        
    loop writeByte1
    
    push print_enter
    call [printf]
    add esp, 1 * 4
    
    mov esi, s2
    mov ecx, leng
    jecxz final_program
    
    writeByte:
        
        push ecx
        
        mov eax, 0
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
        
    loop writeByte
    
   
   
    final_program:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
