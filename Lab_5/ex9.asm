;Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat ;elementele din D sa reprezinte diferenta dintre fiecare 2 elemente consecutive din S.
;Exemplu:

;S: 1, 2, 4, 6, 10, 20, 25
;D: 1, 2, 2, 4, 10, 5


bits 32 


global start        


extern exit, printf              
import exit msvcrt.dll   
import printf msvcrt.dll 
  
segment data use32 class=data
    
    s db 1, 2, 4, 6, 10, 20, 25
    l1 equ ($ - s)
    
    d times l1 db 0
    
    print_frm db "%d ", 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov esi, 0
    mov edi, 0
    mov ecx, l1
    
    diferentaBytes:
    
        mov al, [esi + s]
        inc esi 
        mov bl, [esi + s]
        
        sbb bl, al
        
        mov [d + edi], bl
        inc edi
        
    loop diferentaBytes
    
    xor esi, esi
    mov esi, d
    mov ecx, l1 - 1
    
    writeBytes:
    
        push ecx
        
           lodsb
           push eax
           push print_frm
           call [printf]
           add esp, 2 * 4
        
        pop ecx
        
    loop writeBytes
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
