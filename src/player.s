BITS 64

extern DrawRectangle
extern colorWhite

x_offset equ 0
y_offset equ 4
w_offset equ 0
h_offset equ 4

global initPlayer
global drawPlayer

section .data
p_rect_dim:
    dd          256, 32

section .bss
p_rect_pos:
    resd        2


section .text

initPlayer:
    push rbp
    mov rbp, rsp

    mov rax, 900
    mov [p_rect_pos+x_offset], rax
    mov [p_rect_pos+y_offset], rax

    mov rsp, rbp
    pop rbp
    ret

drawPlayer:
    push rbp
    mov rbp, rsp

    mov rdi,    [p_rect_pos+x_offset]
    mov rsi,    [p_rect_pos+y_offset]
    mov rdx,    [p_rect_dim+w_offset]
    mov rcx,    [p_rect_dim+h_offset]
    mov r8,     0xFFFFFFFF
    call        DrawRectangle

    mov rsp, rbp
    pop rbp
    ret