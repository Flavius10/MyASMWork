; [2*(a+b)-5*c]*(d-3) 

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
    add al, [b]
    
    mov bl, 2
    
    imul bl  ; ax = 2 * (a + b)
    
    xor ebx, ebx
    mov bx, ax   ; bx  = 2 * (a + b)
    xor eax, eax
    
    mov cl, 5
    mov al, [c]
    
    imul cl   ; ax = 5 * c
    
    sub bx, ax   ; bx = 2 * (a + b) - 5 * c
    xor eax, eax
    mov ax, bx   ; ax = 2 * (a + b) - 5 * c
    xor ebx, ebx
    
    mov bx, [d]
    sub bx, 3    ; bx = d - 3
    
    imul bx   ; dx:ax = (2 * (a + b) - 5 * c) * (d - 3)
    
    cwde
    
    push eax
    push print_frm
    call [printf]
    add esp, 8

    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
