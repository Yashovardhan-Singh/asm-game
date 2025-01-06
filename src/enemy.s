extern DrawRectangle
extern GetRandomValue
extern CheckCollisionCircleRec

extern b_pos
extern b_enable
extern initBullet

global initEnemies
global drawEnemy
global updateEnemies

MAX_ENEMIES equ 10

section .bss
    enemies: resd 3 * MAX_ENEMIES
    enemies_dirs: resd MAX_ENEMIES

section .text

initEnemies:
    xor rbx, rbx
.loop:
    call setEnemy
    inc rbx
    cmp rbx, MAX_ENEMIES
    jl .loop
    ret

setEnemy:
    mov rdi, 0
    mov rsi, 1248
    call GetRandomValue
    mov dword [enemies + (rbx*8)], eax
    mov dword [enemies + (rbx*8) + 4], 50
    mov rdi, 1
    mov rsi, 2
    call GetRandomValue
    lea r12, [enemies_dirs + (rbx*4)]
    mov dword [enemies_dirs + (rbx*4)], eax
    ret

updateEnemies:
    xor rbx, rbx
.loop:
    call collideEnemy
    call moveEnemy
    call drawEnemy
    cmp byte [b_enable], 1
    jne .continue
    call enemyBulletCollide
.continue:
    inc rbx
    cmp rbx, MAX_ENEMIES
    jl .loop
    ret

moveEnemy:
    cmp dword [enemies_dirs + (rbx*4)], 1
    je .negative
    cmp dword [enemies_dirs + (rbx*4)], 2
    je .positive
    ret
.negative:
    sub dword [enemies + (rbx*8)], 6
    ret
.positive:
    add dword [enemies + (rbx*8)], 6
    ret

collideEnemy:
    cmp dword [enemies + (rbx*8)], 0
    jle .left
    cmp dword [enemies + (rbx*8)], 1248
    jge .right
    ret
.left:
    mov dword [enemies_dirs + (rbx*4)], 2
    add dword [enemies + (rbx*8) + 4], 25
    ret
.right:
    mov dword [enemies_dirs + (rbx*4)], 1
    add dword [enemies + (rbx*8) + 4], 25
    ret

drawEnemy:
    push rbx
    mov rdi, [enemies + (rbx*8)]
    mov rsi, [enemies + (rbx*8) + 4]
    mov rdx, 32
    mov rcx, 32
    mov r8, 0xFFFFFFFF
    call DrawRectangle
    pop rbx
    ret

enemyBulletCollide:
    mov eax, [enemies + (rbx * 8)]
    mov ecx, [enemies + (rbx * 8) + 4]
    mov edx, [b_pos]
    cmp edx, eax
    jb  .exit
    add eax, 32
    cmp edx, eax
    jnb .exit
    mov edx, [b_pos + 4]
    cmp edx, ecx
    jb  .exit
    add ecx, 32
    cmp edx, ecx
    jnb .exit
    
    call setEnemy
    mov byte [b_enable], 0
    call initBullet
.exit:
    ret