; (100*a+d+5-75*b)/(c-5) 

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
    add ax, 5  ; ax = d + 5
    
    mov bx, ax
    xor eax, eax
    
    mov al, [b]
    mov ah, 75
    imul ah   ; ax = b * 75
    
    sub bx, ax ; bx = d+5-75*b
    
    xor eax, eax
    mov al, [a]
    mov dl, 100
    imul dl    ; ax = a * 100
    
    add ax, bx  ; ax = 100*a+d+5-75*b
    xor ebx, ebx
    mov bx, ax  ; bx = 100*a+d+5-75*b
    
    
    xor eax, eax
    mov al, [c]
    sub al, 5
    
    cbw    ; ax = c - 5
    
    mov dx, bx
    mov bx, ax ; bx = ax
    mov ax, dx ; ax = bx\
    
    xor edx, edx
    cwde
    mov edx, eax ; edx = eax
    
    xor eax, eax
    mov ax, bx
    cwde
    mov ebx, eax  ; ebx - convertire de la bx
    
    mov eax, edx
    
    cdq
    
    idiv ebx  ; eax = edx:eax / ebx    edx = edx:eax % ebx
    
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
