; [d-2*(a-b)+b*c]/2 

bits 32 

global start        

extern exit, printf               
import exit msvcrt.dll 
import printf msvcrt.dll 
   
segment data use32 class=data
    
    a  db 4
	b  db 6
	c  db 3
	d  dw 2 
    
    print_frm db 'Rezultatul este: %d', 0
    cat_frm db 'Catul este: %d', 10, 13, 0
    rest_frm db 'Restul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx
    
    mov al, [a]
    sub al, [b]

    mov bl, 2
    imul bl   ; ax = 2 * (a - b)
    
    xor ebx, ebx
    mov bx, [d]
    sub bx, ax ; bx = d - 2 * (a - b)
    
    xor eax, eax
    mov al, [b]
    mov dl, [c]
    
    imul dl   ; ax = b * c
    
    add ax, bx ; ax = d - 2 * (a - b) + b * c
    
    xor ebx, ebx
    mov bl, 2
    
    idiv bl  ; al = ax / bl   ah = reminder
    
    cbw 
    cwd
    cdq
    
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
