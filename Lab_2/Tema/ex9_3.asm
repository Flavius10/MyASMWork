; 3*[20*(b-a+2)-10*c]+2*(d-3) 
; a,b,c - byte, d - word

bits 32 

global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    
    

segment data use32 class=data
    a db 4
    b db 6
    c db 2
    d dw 4
    
    print_frm db "Rezulatul este: %d", 0
  
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [b]
    sbb al, [a]
    add al, 2
    
    mov bl, 20  
    mul bl   ; ax = 20*(b-a+2)
    
    xor ebx, ebx
    mov bx, ax
    xor eax, eax
    
    mov al, [c]
    mov dl, 10
    mul dl ; ax = 10*c
    
    sbb bx, ax
    
    xor eax, eax
    mov ax, bx ; ax = 20*(b-a+2)-10*c
    xor ebx, ebx
    
    mov bx, 3
    mul bx  ; dx:ax = ax * bx
    
    push dx
    push ax
    pop eax
    
    xor ebx, ebx
    xor edx, edx
    
    mov ebx, eax  ; edx = 3*[20*(b-a+2)-10*c]
    xor eax, eax
    
    mov ax, [d]
    sbb ax, 3
    mov cx, 2
    mul cx
    
    push dx
    push ax
    pop eax
    
    add ebx, eax
    xor eax, eax
    mov eax, ebx
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
  
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
