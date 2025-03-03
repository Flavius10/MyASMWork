; a,b,c - byte, d - word
; ((a+b-c)*2 + d-5)*d 

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
    
    mov al, [a]
    add al, [b]
    sub al, [c]
    
    mov dl, 2
    mul dl      ; ax = (a+b-c)*2
    
    add ax, [d]
    sub ax, 5   ; ax = ((a+b-c)*2 + d-5)
    
    mov bx, [d]
    mul bx      ; dx:ax = ((a+b-c)*2 + d-5)*d 
    
    push eax
    
    push print_frm
    call [printf]
    add esp, 8
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
