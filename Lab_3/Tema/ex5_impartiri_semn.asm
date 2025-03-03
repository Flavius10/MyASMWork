; a,b,d-byte; c-word; e-doubleword; x-qword
; x + a/b + c*d - b/c + e = 10 + 0 + 2 - 50 + 10 = -28

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data 
   
    a db 10
    b db 100
    c dw 2
    d db 1
    e dd 10
    x dq 10
   
   print_frm db 'Rezultatul este %d', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    ; x + a/b + c*d - b/c + e
    
    mov al, [a]
    cbw
    mov bl, [b]
    idiv bl ; al = ax / bl
    
    ; 10 / 100

    xor ebx, ebx
    mov bl, al ; bl = a / b
    xor eax, eax
    
    mov al, [d]
    cbw
    mov cx, ax  ; cx = d
    
    xor eax, eax
    
    mov ax, [c] ; ax = c
    imul cx ; dx:ax = ax * bx
    push dx
    push ax
    pop eax ; eax = c * d
    
    xor ecx, ecx
    mov ecx, eax ; ecx = c * d
    xor eax, eax
    
    mov al, bl
    cbw
    cwde
    
    adc eax, ecx ; eax = c * d + a / b 
    
    xor ebx, ebx
    xor ecx, ecx
    
    mov ecx, eax  ; ecx = c * d + a / b
    xor eax, eax
    
    mov al, [b]
    cbw
    cwd
    mov bx, [c]
    idiv bx ;   ax = dx:ax / bx
    cwde
        
    xor edx, edx
    sub ecx, eax  ; ecx = a/b + c*d - b/c
    
    add ecx, [e] ; ecx = a/b + c*d - b/c + e
    
    xor eax, eax
    mov eax, ecx ; eax = a/b + c*d - b/c + e
        
    cdq
    
    adc eax, [x]
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
