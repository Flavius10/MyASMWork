; –a*a + 2*(b-1) – d 

bits 32 

global start        

extern exit, printf               
import exit msvcrt.dll 
import printf msvcrt.dll 
   
segment data use32 class=data
    
    a  db 6
	b  db 4
	c  db 3
	d  dw 2 
    
    print_frm db 'Rezultatul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    
    add al, [b]
    sub al, 1  ; al = b - 1
    
    mov bl, 2
    imul bl    ; ax = 2 * (b - 1)
    
    xor ebx, ebx ; ebx = 0
    sub ax, [d]  ; ax = 2 * (b - 1) - d
    
    cwde
    
    mov ecx, eax   ; ecx = 2 * (b - 1) - d
    
    xor eax, eax   ; eax = 0
    mov al, [a]
    mov bl, [a]
    
    imul bl      ; ax = a * a

    mov dx, ax
    xor ax, ax
    mov ax, -1
    imul dx    ; dx:ax = ax * dx = -a*a
    
    cwde
    
    add eax, ecx
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
  
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
