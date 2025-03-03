bits 32 
global start        


extern exit, printf
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    a dw 128
    b dw 128

    print_frm db 'Suma este = %hu', 0
    
segment code use32 class=code
start:
    
    mov ax, [a]
    add ax, [b]
    push ax
    
    push print_frm
    call [printf]
    add esp, 6
    
        
