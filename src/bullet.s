%include "include/hardware.inc"

extern IsKeyPressed
extern DrawCircle

extern p_rect_pos

global initBullet
global updateBullet
global b_enable
global b_pos

section .data
    radius: dd 6.0

section .bss
    b_pos: resd 2
    b_enable: resb 1

section .text

initBullet:
    mov eax, [p_rect_pos]
    mov dword [b_pos], eax
    mov dword [b_pos + 4], 600
    ret

moveBullet:
    sub dword [b_pos + 4], 24
    ret

drawBullet:
    mov rax, [b_pos]
    add rax, 16
    mov rdi, rax
    mov rsi, [b_pos+4]
    movss xmm0, [radius]
    mov rdx, 0xFFFFFFFF
    call DrawCircle
    ret

isBulletFired:
    mov rdi, KEY_SPACE
    call IsKeyPressed
    cmp rax, 1
    jne .exit
    cmp byte [b_enable], 1
    je .exit
    mov byte [b_enable], 1
    call initBullet
.exit:
    ret

disableBullet:
    cmp dword [b_pos + 4], 0
    jg .exit
    mov byte [b_enable], 0
.exit:
    ret

updateBullet:
    call isBulletFired
    cmp byte [b_enable], 1
    jne .exit
    call moveBullet
    call drawBullet
    call disableBullet
.exit:
    ret