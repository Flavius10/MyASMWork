; a,b,c - byte, d - word
; d*(d+2*a)/(b*c)
;    28 / 12
; c = 2 , r = 4 

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
    catul_frm db 'Catul este: %d', 10, 13, 0
    rest_frm db 'Restul este: %d' , 0
   
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    
    mov al, [a]
    mov dl, 2
    mul dl   ; ax = a * 2
    
    add ax, [d]  ; ax = (d+2*a)
    mul word [d]  ; dx:ax = d*(d+2*a)
    
    mov bx, ax    ; bx = d*(d+2*a)
    
    xor eax, eax  ; eax = 0
    
    mov al, [b]
    mul byte [c]  ; ax = b * ca
    
    xor edx, edx  ; edx = 0
    ; regula celor trei pahare
    mov dx, bx
    mov bx, ax
    mov ax, dx
    
    cwd
    
    div bx  ; ax = dx:ax / bx   dx = dx:ax % bx
    
    push edx
    
    push eax
    push catul_frm
    call [printf]
    add esp, 8
    
    push rest_frm
    call [printf]
    add esp, 8
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
