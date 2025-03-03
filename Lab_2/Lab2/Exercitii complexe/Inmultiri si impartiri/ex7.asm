; [100*(d+3)-10]/d 

bits 32 

global start        

extern exit, printf               
import exit msvcrt.dll 
import printf msvcrt.dll 
   
segment data use32 class=data
    
    a  db 4
	b  db 6
	c  db 3
	d  dw 3 
    
    print_frm db 'Rezultatul este: %d', 0
    cat_frm db 'Catul este: %d', 10, 13, 0
    rest_frm db 'Restul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx
    
    mov ax, [d]
    add ax, 3
    
    mov bx, 100
    imul bx  ; dx:ax = 100*(d+3)
    
    sub ax, 10
    
    idiv word [d]
    
    cwde
    
    push edx
    push eax
    push cat_frm
    call [printf]
    add esp, 8
    
    pop edx
    
    push edx
    push rest_frm
    call [printf]
    add esp, 8
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
