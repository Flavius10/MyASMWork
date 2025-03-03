bits 32 
global start        


extern exit, printf, fclose, fopen, scanf, fprintf, fread           
import exit msvcrt.dll    
import printf msvcrt.dll    
import fclose msvcrt.dll    
import fopen msvcrt.dll    
import scanf msvcrt.dll    
import fprintf msvcrt.dll    
import fread msvcrt.dll 
   
segment data use32 class=data

    descriptor dd -1, 0
    mode_access db "r", 0
    nume_fisier db "cifre_pare.txt", 0
    
    len equ 100
    text times len db 0
    
    nr_numere_pare db "Numarul de numere pare este: %d", 0
    print_frm db "%c ", 0
    
    
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push dword mode_access
    push dword nume_fisier
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je final
    
    push dword [descriptor]
    push dword len
    push dword 1
    push dword text
    call [fread]
    add esp, 4 * 4
    
    xor esi, esi
    mov esi, text
    xor edx, edx

    numere_pare:
    
        xor eax, eax
        
        mov al, [esi + ebx]
        
        cmp al, 0
        je done
        
        cmp al, "0"
        je par
        
        cmp al, "2"
        je par
        
        cmp al, "4"
        je par
        
        cmp al, "6"
        je par
        
        cmp al, "8"
        je par
        
        jmp incrementare
        
        par:
            inc edx
        
        incrementare:
            inc ebx
    
    jmp numere_pare
    
    
    done:
    
        push edx
        push nr_numere_pare
        call [printf]
        add esp, 2 * 4
    
        push dword [descriptor]
        call [fclose]
        add esp, 4
    
    
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
