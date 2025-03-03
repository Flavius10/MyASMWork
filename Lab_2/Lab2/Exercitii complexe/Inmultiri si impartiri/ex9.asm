; 3*[20*(b-a+2)-10*c]+2*(d-3) 

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
    
    mov al, [b]
    sub al, [a]
    add al, 2  ; al = b - a + 2
    
    add bl, 20
    imul bl  ; ax = bl * al = 20 * (b - a + 2)
    
    mov dx, ax  ; dx = 20 * (b - a + 2)
    xor eax, eax  ; eax = 0
    
    xor ebx, ebx
    mov bl, 10
    mov al, [c]
    
    imul bl  ; ax = 10 * call
    sub dx, ax
    mov ax, dx  ; ax = 20*(b-a+2)-10*c
    
    xor edx, edx
    mov dx, 3
    
    imul dx  ; dx:ax = 3*[20*(b-a+2)-10*c]
    
    xor ebx, ebx
    mov bx, ax
    
    xor eax, eax
    mov ax, [d]
    sub ax, 3
    
    xor edx, edx
    mov dl, 2
    
    imul dl ; ax = 2*(d-3)
    
    add bx, ax
    mov ax, bx
    
    cwde
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
