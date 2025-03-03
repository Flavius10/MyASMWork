bits 32 
global start        


extern exit, printf, scanf              
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    
    a dd 0
    b dd 0
    
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
    
    mov eax, [a]
    mov ebx, [b]
    
    xor edx, edx ; edx:eax = eax = a
    
    div dword [b] ; edx:eax / ebx = eax(catul)
    mov ebx, k
    mul ebx  ; edx:eax = ebx * eax 
    
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
