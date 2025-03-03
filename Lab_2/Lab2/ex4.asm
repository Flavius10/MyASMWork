bits 32 
global start        


extern exit, printf             
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data
    
    a db 5
    b db 6
    
    print_frm db 'Rezultatul este: %hd', 0
    
   
segment code use32 class=code
start:
    
    mov al, [a]
    sub al, [b]
    cbw 
    push ax
    
    push print_frm
    call [printf]
    add esp, 6
        
     
