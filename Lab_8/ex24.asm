;Se citesc de la tastatura doua numere a si b. Sa se calculeze valoarea expresiei (a/b)*k, k fiind o constanta definita in segmentul de date. Afisati valoarea expresiei (in baza 2). 

bits 32 
global start        


extern exit, printf, scanf              
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    
    a dd 0
    b dd 0
    rezultat dq 0
    
    k equ 3
    
    print_frm db "Rezultatul este: %lld", 10, 0
    format db "%d", 0
    
segment code use32 class=code
start:

    push dword a
    push format
    call [scanf]
    add esp, 2 * 4
    
    push dword b
    push format 
    call [scanf]
    add esp, 2 * 4
    
    xor edx, edx
    mov eax, [a]
    mov ebx, [b]
    
    div ebx  ; edx:eax = eax / ebx
    mov ebx, k
    mul ebx ; edx:eax = ebx * eax = edx:eax / ebx * k
    
    push edx
    push eax
    
    ; stiva 
    
    ; eax
    ; edx
    
    pop dword [rezultat]
    pop dword [rezultat + 4] ; rezultat este rezultatul calculului (a / b) * k
    
    push dword [rezultat + 4]
    push dword [rezultat]
    push print_frm
    call [printf]
    add esp, 3 * 4
    
    mov ecx, 31
    mov ebx, 0
    
    scrieBitHigh:
    
        push ecx
        
            mov ebx, 1
            shl ebx, cl
            mov eax, [rezultat + 4]
            and eax, ebx
            shr eax, cl
            
            push eax
            push format
            call [printf]
            add esp, 2 * 4
        
        pop ecx
    
    loop scrieBitHigh
    
    mov ecx, 31
    mov ebx, 0
    
    scrieBitLow:
    
        push ecx
        
            mov ebx, 1
            shl ebx, cl
            mov eax, [rezultat]
            and eax, ebx
            shr eax, cl
            
            push eax
            push format
            call [printf]
            add esp, 2 * 4
        
        pop ecx
    
    loop scrieBitLow
    
    mov eax, [rezultat]
    mov ebx, 1
    and eax, ebx
    
    push eax
    push format
    call [printf]
    add esp, 2 * 4
           
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
