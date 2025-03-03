; Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura numere si sa se scrie din valorile citite in fisier numerele divizibile cu 7, pana cand se citeste de la tastatura valoarea 0. 

bits 32
global start        

extern exit, printf, scanf, fopen, fclose, fprintf       
        
import exit msvcrt.dll   
import printf msvcrt.dll   
import scanf msvcrt.dll   
import fopen msvcrt.dll   
import fclose msvcrt.dll   
import fprintf msvcrt.dll   

segment data use32 class=data

    mode_acces db "a", 0
    descriptor dd -1
    name_file db "ex17.txt", 0
    
    numar dd 0
    
    format_string db "%s", 0
    format_int db "%d", 0
    
    print_frm_int db "%d ", 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push dword mode_acces
    push dword name_file
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je final
    
    citire_numere:
    
        push dword numar
        push dword format_int
        call [scanf]
        add esp, 2 * 4
        
        mov eax, [numar]
        
        cmp eax, 0
        je inchidere
        
        ; verificare multipu de 7
        xor edx, edx
        mov ebx, 7
        div ebx
        
        cmp edx, 0
        je add_to_file
        
        jmp next
        
        add_to_file:
        mov eax, dword [numar]
        
        push eax
        push print_frm_int
        push dword [descriptor]
        call [fprintf]
        add esp, 3 * 4
        
        next:
        
    jmp citire_numere
    
    
    inchidere:
        push dword [descriptor]
        call [fclose]
        add esp, 1 * 4
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
