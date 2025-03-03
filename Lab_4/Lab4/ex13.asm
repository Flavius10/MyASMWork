;Dandu-se 4 octeti, sa se obtina in AX suma numerelor intregi reprezentate de bitii 4-6 ai celor 4 octeti.

bits 32 
global start        

extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll    
segment data use32 class=data

    A db 10011011b
    B db 01001010b
    C db 10010101b
    D db 10100110b
    
    print_frm db "Rezultatul este: %u", 0
    
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [A]
    and al, 01110000b
    shr al, 4
    
    add dx, ax
    
    mov al, [B]
    and al, 01110000b
    shr al, 4
    
    add dx, ax
    
    mov al, [C]
    and al, 01110000b
    shr al, 4
    
    add dx, ax
    
    mov al, [D]
    and al, 01110000b
    shr al, 4
    
    add dx, ax
    mov ax, dx
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
