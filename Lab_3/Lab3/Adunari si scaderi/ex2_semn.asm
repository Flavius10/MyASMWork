; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
; (c+b)-a-(d+d) 
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
    
    mov eax, [d]
    adc eax, [d]
    
    mov edx, eax ; edx = d + d
    xor eax, eax
    
    mov ax, [b]
    cwde
    adc eax, [c]  ; eax = c + b
    sbb eax, edx  ; eax = (c + b) - (d + d)
    xor edx, edx
    mov edx, eax
    
    xor eax, eax
    mov al, [a]
    cbw
    cwde
    
    sbb edx, eax  ; edx = (c + b) - (d + d) - a
    
    xor eax,eax
    mov eax, edx
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
