;Se da un sir de dublucuvinte. Sa se ordoneze descrescator sirul cuvintelor inferioare ale acestor dublucuvinte. Cuvintele superioare raman neschimbate.
;Exemplu:
;dandu-se:

;sir DD 12345678h 1256ABCDh, 12AB4344h

;rezultatul va fi

;1234ABCDh, 12565678h, 12AB4344h.


bits 32 
global start        


extern exit, printf         
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data

    s dd 12345678h, 1256ABCDh, 12AB4344h
    leng_dword equ ($ - s) / 4
    leng_word equ leng_dword * 2
    
    sir_low times leng_dword dw 0
    sir_high times leng_dword dw 0
    sir_low_modified times leng_dword dw 0
    
    sir_general times leng_dword * 2 dw 0
    
    print_frm db "%04Xh ", 0
    
   
segment code use32 class=code
start:

    ; ========= load sir_high ===========
    mov ecx, leng_dword
    mov esi, s + 2
    mov edi, sir_high
    
    
    
    sir_high_load:
    
        movsw
        add esi, 2
        
    loop sir_high_load
    
    ;====================================
    
    
    ;============ sir_low load ==========
    mov ecx, leng_dword
    mov esi, s
    mov edi, sir_low
    
    sir_low_load:
    
        movsw
        add esi, 2
    
    loop sir_low_load
    
    ;====================================
    
    ;=========== sort low words =========
    
    ;5678h,  ABCDh,  4344h
    ;4344h, ABCDh, 5678h
    
    ;ABCDh,  4344h,  5678h
    
    cld 
    mov esi, 0
    mov edi, 0
    
    outerLoop:
        
        cmp esi, leng_dword - 1 ; esi <= 2
        je final
        
        mov edi, esi
        ;add edi, 2
        inc edi
        
        innerLoop:
        
            cmp edi, leng_dword
            je resume
            
            mov ax, [sir_low + esi * 2] ; 5678h
            cmp ax, [sir_low + edi * 2] ; 5678h <= ABCDh
            jle next
            
            mov bx, [sir_low + edi * 2]
            mov [sir_low + esi * 2], bx ; regula celor trei pahare
            mov [sir_low + edi * 2], ax
         
            next:
            ;add edi, 2
            inc edi
        
        jmp innerLoop
        
        resume:
        ;add esi, 2
        inc esi
        
    jmp outerLoop
    
    final:    
;        for (int i = 1; i < n; ++i) esi
;            for (int j = i + 1; j <= n; ++j) edi
;                if (s[i] > s[j])
;                    swap(s[i], s[j])
                
    
    ;====================================
    
    ;============= move sorted array ====
    
    cld
    mov esi, sir_low
    mov edi, sir_low_modified
    
    mov ecx, leng_dword
    
    moveWords:
    
        movsw
    
    loop moveWords
        
        
    ;============ write array words =====
    mov ecx, leng_dword
    mov esi, sir_low_modified
    
    writeWordsHigh:
    
        push ecx
        
        xor eax, eax
        lodsw
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
    
    loop writeWordsHigh
    
    ;====================================
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
