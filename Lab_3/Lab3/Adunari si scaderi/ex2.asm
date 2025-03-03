; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
; (b+b)+(c-a)+d 
bits 32 

global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data
    
    a db 10
    b dw 5
    c dd 6
    d dq 100

    print_frm db 'Rezulatul este: %d'
    
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov ax, [b]
    add ax, [b]  ; ax = b + b
    
    cwde  ; eax = b + b
    add eax, [d]  ; eax = b + b + d
    
    mov ebx, eax ; ebx = eax = b + b + d
    xor eax, eax  ; eax = 0
    
    mov eax, [c]
    add eax, ebx  ; eax = b + b + d + c
    
    xor ebx, ebx
    mov ebx, eax
    mov al, [a]
    cbw
    cwde  ; eax = a
    
    mov ecx, eax
    xor eax, eax
    mov eax, ebx
    sub eax, ecx ; eax = (b+b)+(c-a)+d
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
