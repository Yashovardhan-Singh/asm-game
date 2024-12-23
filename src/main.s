BITS 64

extern InitWindow
extern SetTargetFPS
extern BeginDrawing
extern ClearBackground
extern EndDrawing
extern WindowShouldClose
extern CloseWindow

extern initPlayer
extern drawPlayer
extern moveLeft
extern moveRight

extern initEnemy
extern drawEnemy

section .data
    msg: db "Hello, World!", 0

section .text
    global _start

_start:

    mov rdi, 1280
    mov rsi, 720
    lea rdx, [msg]
    call InitWindow

    mov rdi, 60
    call SetTargetFPS

    call initPlayer
    call initEnemy

game_loop:

    call moveLeft
    call moveRight

    call BeginDrawing

    mov rdi, 0x0
    call ClearBackground

    call drawPlayer
    call drawEnemy      ; Todo, enemies not drawing

    call EndDrawing

    call WindowShouldClose
    cmp rax, 0
    jz game_loop

    call CloseWindow

    mov rax, 60
    mov rdi, 0
    syscall