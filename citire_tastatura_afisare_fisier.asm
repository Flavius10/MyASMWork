bits 32 

global start        

extern exit, fopen, fprintf, fclose, scanf
import exit msvcrt.dll  
import scanf msvcrt.dll  
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    nume_fisier db "output.txt", 0 
    mod_acces db "w", 0                                              
    format db "%s", 0                  
    descriptor_fis dd -1 
    buffer times 256 db 0
                                    
segment code use32 class=code
    start:
        push dword buffer       
        push dword format       
        call [scanf]            
        add esp, 4 * 2
    
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4 * 2                

        mov [descriptor_fis], eax  
        
        cmp eax, 0
        je final

        push dword [descriptor_fis]
        push dword buffer
        push dword format
        call [fprintf]
        add esp, 4 * 3

        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
    final:
        push    dword 0      
        call    [exit]       