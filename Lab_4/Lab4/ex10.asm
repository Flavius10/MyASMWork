; Sa se inlocuiasca bitii 0-3 ai octetului B cu bitii 8-11 ai cuvantului A. 

bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A dw 1010110101000101b
    B db 0 
    
    print_frm db 'Rezultatul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx  ; aici se va salva C
    xor ecx, ecx 
    
    mov ax, [A]
    and ax, 0000111100000000b
    ror ax, 8
    or bx, ax  ; primii patru biti sunt bitii 8-11 a lui A
    
    xor eax, eax
    mov al, [B]
    and al, 11110000b
    or ax, bx
    
    mov [B], ax
    
    push    dword 0     
    call    [exit]