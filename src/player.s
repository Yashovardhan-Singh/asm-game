BITS 64

%include "include/hardware.inc"

extern DrawRectangle
extern IsKeyDown

global initPlayer
global drawPlayer
global moveLeft
global moveRight

global p_rect_pos

section .bss
    p_rect_pos: resd 1

section .text

initPlayer:
    mov rax, 20
    mov [p_rect_pos], rax
    ret

drawPlayer:
    mov rdi, [p_rect_pos]
    mov rsi, 600
    mov rdx, 32
    mov rcx, 32
    mov r8,  0xFFFFFFFF
    call     DrawRectangle
    ret

moveLeft:
    mov rdi, KEY_A
    call IsKeyDown
    cmp rax, 1
    jne .exit
    mov rax, [p_rect_pos]
    sub rax, 12
    cmp rax, 0
    jle .exit
    mov [p_rect_pos], rax
.exit:
    ret

moveRight:
    mov rdi, KEY_D
    call IsKeyDown
    cmp rax, 1
    jne .exit
    mov rax, [p_rect_pos]
    add rax, 12
    cmp rax, 1248
    jge .exit
    mov [p_rect_pos], rax
.exit:
    ret