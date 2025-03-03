; Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de consoane si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date. 
bits 32 
global start        

extern exit, printf, fscanf, fprintf, fopen, fclose, fread       
import exit msvcrt.dll
import printf msvcrt.dll     
import fscanf msvcrt.dll    
import fprintf msvcrt.dll    
import fopen msvcrt.dll    
import fclose msvcrt.dll 
import fread msvcrt.dll 
   
segment data use32 class=data

    nume_fisier db "nr_vocale.txt", 0
    mod_access db "r", 0
    
    len equ 100
    text times 100 db 0
    textul_format db "%s", 0
    
    descriptor_fis dd -1
    nr_vocale db "Numarul de vocale este=%d", 0
    print_frm db "%c", 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx
    
    push dword mod_access
    push dword nume_fisier
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor_fis], eax
    
    cmp eax, 0
    je final
    
    push dword [descriptor_fis]
    push dword len
    push dword 1
    push dword text
    call [fread]
    add esp, 4 * 4
    
    mov esi, text
    xor ebx, ebx
    xor edx, edx
    
    scrie_biti:
    
        xor eax, eax
        
        mov al, [esi + ebx]
        
        cmp al, 0
        je done
        
        cmp al, "a"
        je vocala
        
        cmp al, "e"
        je vocala
        
        cmp al, "i"
        je vocala
        
        cmp al, "o"
        je vocala
        
        cmp al, "u"
        je vocala
        
        jmp increment
        
        vocala:
            inc edx
        
        increment:
            inc ebx
    
    jmp scrie_biti
    
    sub ebx, edx
    
    done:
        push ebx
        push nr_vocale
        call [printf]
        add esp, 2 * 4
        
    final:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
