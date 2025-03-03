; Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si caractere speciale. Sa se inlocuiasca toate CIFRELE din textul dat cu caracterul 'C'. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut prin inlocuire in fisier. 

bits 32 
global start        


extern exit, fprintf, fopen, fclose, printf           
import exit msvcrt.dll    
import fprintf msvcrt.dll    
import fopen msvcrt.dll    
import fclose msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data

    nume_fisier db "cifre_out.txt", 0
    mod_acces db "w", 0
    
    text_cerinta db "In 2024 tehnologia avanseaza rapid iar 72 dintre utilizatori prefera solutii digitale In ultimii 5 ani 98 din companii au adoptat metode automate In acest context transformarea digitala devine esentiala pentru a ramane competitivi si pentru a maximiza eficienta operatiunilor.", 0
    
    leng equ ($ - text_cerinta)
    
    text_modificat times leng db 0

    descriptor_fis dd -1
    print_frm db "%c", 0
   
segment code use32 class=code
start:
    
    ; open the file
    push dword mod_acces
    push dword nume_fisier
    call [fopen]
    add esp, 2 * 4
    
    ; take the descriptor(if file it's open or not)
    mov [descriptor_fis], eax
    
    ; check if the file could be open
    cmp eax, 0
    je final
    
    ; replace all digits with 'C'
    mov esi, text_cerinta
    mov edi, text_modificat
    
    xor ebx, ebx
    
    replace_loop:
        
        mov eax, 0
        mov al, [esi + ebx] 
        
        cmp al, 0
        je done
    
        cmp al, '0'
        jl next_char
        cmp al, '9'
        jg next_char
        
        mov al, 'C'
        jmp next_char
        
    next_char:
        mov byte [edi + ebx], al
        
        inc ebx
    jmp replace_loop
  
    
    ;write the text into the "cifre_out.txt" file
    done:
        push dword text_modificat
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 2 * 4
    
    ;close the file
    push dword [descriptor_fis]
    call [fclose]
    add esp, 4
  
    ;close the program
    final:
        push    dword 0      
        call    [exit]      
