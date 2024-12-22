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

section .data
msg:
    db          "Hello, World!", 0
colorWhite:
    dd          0xFFFFFFFF
colorBlack:
    dd          0x0

rectanglePlayer:
    dd          0, 0, 200, 200

section .text
    global      _start

_start:

    mov rdi,    1920
    mov rsi,    1080
    lea rdx,    [msg]
    call        InitWindow

    mov rdi,    60
    call        SetTargetFPS

    call        initPlayer

game_loop:

    call        BeginDrawing

    mov rdi,    [colorBlack]
    call        ClearBackground

    call        drawPlayer

    call        EndDrawing

    call        WindowShouldClose
    cmp rax,    0
    jz          game_loop

    call        CloseWindow

    mov rax,    60
    mov rdi,    0
    syscall