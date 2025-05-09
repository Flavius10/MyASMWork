bits 32 
global start        


extern exit, printf        
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    a db 10
    b dw 4
    
    cat_frm db 'Catul este: %d', 10, 13, 0
    rest_frm db 'Restul este: %d'
   
segment code use32 class=code
start:
    
    mov eax, 0
    mov edx, 0
    
    mov al, [a] ; valoarea lui a este plasata in ax
    cbw         ; extindem de la al la ax
    cwd         ; ax  -> dx:ax
    
    div word [b] ; ax = dx:ax / b    dx  = dx:ax % b
    
    push edx
    
    push eax
    push cat_frm
    call [printf]
    add esp, 8
    

    push rest_frm
    call [printf]
    add esp, 8
    
    
    push dword 0      ; push the parameter for exit onto the stack
    call [exit]       ; call exit to terminate the program
      