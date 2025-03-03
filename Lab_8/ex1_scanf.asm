; Sa se citeasca de la tastatura doua numere (in baza 10) si sa se calculeze produsul lor. Rezultatul inmultirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date). 

bits 32


global start        


extern exit, printf, scanf   
          
import exit msvcrt.dll   
import printf msvcrt.dll   
import scanf msvcrt.dll 
 
segment data use32 class=data

    a db 0
    b dd 0
    
    rezultat dd 0
    
    format_citire db "%d", 0
    format_scriere db "%d", 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push dword a
    push format_citire
    call [scanf]
    add esp, 2 * 4
    
    push dword b
    push format_citire
    call [scanf]
    add esp, 2 * 4
    
    mov al, [a]
    mov bl, [b]
    
    mul bl
    
    xor ebx, ebx
    mov bx, ax
    
    xor eax, eax
    mov ax, bx
    
    mov [rezultat], eax
    
    push dword [rezultat]
    push format_scriere
    call [printf]
    add esp, 2 * 4
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
