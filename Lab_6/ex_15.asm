
;Se da un sir S de dublucuvinte.
;Sa se obtina sirul D format din octetii dublucuvintelor din sirul D sortati in ordine descrescatoare in interpretarea fara semn.
;Exemplu:

;s DD 12345607h, 1A2B3C15h
;d DB 56h, 3Ch, 34h, 2Bh, 1Ah, 15h, 12h, 07h

bits 32 
global start        


extern exit, printf              
import exit msvcrt.dll   
import printf msvcrt.dll
 
segment data use32 class=data

    s dd 12345607h, 1A2B3C15h
    lengs equ ($ - s) / 4
    len_sort equ lengs * 4
    
    sort times lengs * 4 db 0
    d times lengs * 4 db 0

    print_frm db "%02Xh ", 0
  
segment code use32 class=code
start:

    xor ebx, ebx
    xor edx, edx
    
    cld
    mov esi, s
    mov edi, sort
    mov ecx, lengs * 4
    
;   =========== add to [sort] array =========
    loadDoubleWordSort:
        movsb
    loop loadDoubleWordSort

    
    
;   =========== sort the [sort] array ======
    cld 
    mov edx, 0
    mov esi, 0
    
    outerLoop:
        cmp esi, len_sort ; edx e lungimea numarul de biti sau nr de dd / 4, iar daca am ajuns cu esi la 4 inseamna ca am sortat toti cei patru biti din dd
        je final 
        mov edi, esi ; esi = i , edi = i
        inc edi  ; edi = i + 1
        
        innerLoop:
            cmp edi, len_sort ; verificam daca am ajuns cu j la lungimea 4(nr de biti dintr-un dd)
            je resume; daca da, incrementam i(esi)
            
            mov al, [sort + esi] ; pe linia asta si cea de sub comparam doua elemente (sort[i] si 
            cmp al, [sort + edi] ; sort[j])
            jge next ; daca is egale incrementam edi
            
            mov bl, [sort + edi]
            mov [sort + esi], bl ; regula celor trei pahare
            mov [sort + edi], al
        
            next:
                inc edi  ; j++
        jmp innerLoop
        
        resume:
        inc esi  ; ++i
        done:
    jmp outerLoop

    final:

;    for (int k = 1; k <= 2; ++k) edx
;        for (int i = 1; i < n; ++i) esi
;            for (int j = i + 1; j <= n; ++j) edi
;                if (s[i] > s[j])
;                    swap(s[i], s[j])
                
    
;   =========== store all bytes ========

    mov esi, sort
    mov edi, d
    mov ecx, len_sort
    
    movBytes:
        
        movsb
        
    loop movBytes
    
        
;   =========== write all bytes sorted ======

    mov ecx, lengs * 4
    mov esi, d
    
    writeBytes:
        
        push ecx
        
        mov eax, 0
        lodsb
        push eax
        push print_frm
        call [printf]
        add esp, 2 * 4
        
        pop ecx
        
    loop writeBytes
 
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
