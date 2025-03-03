; Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si caractere speciale. Sa se inlocuiasca toate caracterele speciale din textul dat cu caracterul 'X'. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier. 

bits 32 
global start        


extern exit, printf, scanf, fprintf, fopen, fclose, fread              
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll    
import fprintf msvcrt.dll    
import fopen msvcrt.dll    
import fclose msvcrt.dll    
import fread msvcrt.dll    

segment data use32 class=data

    mod_acces db "w", 0
    descriptor dd -1 
    nume_fisier db "ex15.txt", 0
    
    len equ 1000
    text times len db "Intr-un mic oras de munte, situat la altitudinea de 1.200 de metri, traiau doar 354 de oameni. In fiecare dimineata, la ora 6:30, soarele rasarea peste varful cel mai inalt, numit Varful Lupului, de 2.145 de metri. Scoala din sat avea 12 elevi, iar fiecare clasa era decorata cu 5 tablouri desenate de copii. Pe strazile inguste, circulau doar 3 masini vechi, iar distanta dintre sat si cel mai apropiat oras era de 25 de kilometri. In fiecare weekend, localnicii organizau targuri unde se vindeau 200 de produse @traditionale, #branzeturi, $miere si %obiecte artizanale. Atmosfera era mereu plina de viata!", 0
    
    text_modificat times len db 0, 0 
    
    print_c db "%c", 0
    print_len db "%d", 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov esi, text
    mov edi, text_modificat
    
    modifica_caractere_speciale:
    
        lodsb
        
        cmp al, 0
        je pune_in_fisier
        
        cmp al, ","
        je modifica
        
        cmp al, "!"
        je modifica
        
        cmp al, "@"
        je modifica
        
        cmp al, "#"
        je modifica
        
        cmp al, "$"
        je modifica
        
        cmp al, "%"
        je modifica
        
        cmp al, "."
        je modifica
        
        cmp al, ":"
        je modifica
        
        jmp adauga
        
        modifica:
            mov al, "X"
            
        adauga:
            stosb
    
    jmp modifica_caractere_speciale
    
    pune_in_fisier:
    
    push dword mod_acces
    push dword nume_fisier
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je final
    
    push dword text_modificat
    push dword [descriptor]
    call [fprintf]
    add esp, 2 * 4
    
    push dword [descriptor]
    call [fclose]
    add esp, 1 * 4
    
   
    final:
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
