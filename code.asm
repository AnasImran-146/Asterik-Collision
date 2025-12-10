;This is my assembly project !!!!!!
[org 0x100]

jmp main

clrscr:
    push bp
    mov  bp, sp
    push es
    push ax
    push di

    mov  ax, 0xb800
    mov  es, ax
    mov  di, 0
    mov  ax, 0x0720       

    cs_loop:
        mov  [es:di], ax  
        add  di, 2        
        cmp  di, 4000     
        jne  cs_loop

    pop  di
    pop  ax
    pop  es
    pop  bp
ret

delay:
    push cx
    push bx

    mov  cx, 0xFFEE      
    d1:
        mov  bx, 10       
        d2:
            sub bx, 5
        jnz  d2
    loop d1

    pop  bx
    pop  cx
ret

show_frame:
    push bp
    mov  bp, sp
    push es
    push ax
    push di      
    push bx      

    mov  ax, 0xb800
    mov  es, ax

    mov  ax, [bp+4]       
    shl  ax, 1            
    mov  bx, 1920       
    add  bx, ax         

    mov  ax, 79
    sub  ax, [bp+4]      
    shl  ax, 1            
    mov  di, 1920        
    add  di, ax      

    mov  word [es:bx], 0x072A
    mov  word [es:di], 0x072A

    call delay

    mov  word [es:bx], 0x0720
    mov  word [es:di], 0x0720  

    pop  bx
    pop  di      
    pop  ax
    pop  es
    pop  bp
ret  2                

start_animation:
    push bp
    mov  bp, sp
    sub  sp, 2            
                         

    animation_loop:

        mov  word [bp-2], 0

        loop_in:
            push word [bp-2]
            call show_frame

            inc  word [bp-2]  
            cmp  word [bp-2], 40
        jne  loop_in

        mov  word [bp-2], 39 

        loop_out:
            push word [bp-2]
            call show_frame

            dec  word [bp-2]
            cmp  word [bp-2], -1
        jne  loop_out

    jmp animation_loop 

    mov sp, bp
    pop bp
ret

main:
    call clrscr           
    call start_animation 

mov ax, 0x4c00
int 0x21