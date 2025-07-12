.intel_syntax noprefix
.global _start
_start:
        #socket
        mov rax,41
        mov rdi,2 #AF_INET
        mov rsi,1 #SOCK_STREAM
        mov rdx,0
        syscall

        #bind
        mov rdi,rax
        mov rax,49
        sub rsp,16 #SOCKADDR_IN
                mov WORD PTR [rsp],2 #sin_family
                mov WORD PTR [rsp+2],0x5000
                mov DWORD PTR[rsp+4],0x0
                mov BYTE PTR[rsp+8],0x0
        mov rsi,rsp
        mov rdx,16
        syscall
        #listen
        mov rax,50
        mov rsi,0
        syscall
	#accept
	mov rax,43
	mov rsi,0
	mov rdx,0
	syscall
	mov rdi,rax
	#read
	mov rax,0
	mov rsi,0
	mov rdx,16
	syscall
	#write
	mov rax,1
	sub rsp,19 #HTTP/1.0 200 OK
                mov BYTE PTR [rsp], 0x48
                mov BYTE PTR [rsp+1], 0x54
                mov BYTE PTR [rsp+2], 0x54
                mov BYTE PTR [rsp+3], 0x50
                mov BYTE PTR [rsp+4], 0x2F
                mov BYTE PTR [rsp+5], 0x31
                mov BYTE PTR [rsp+6], 0x2E
                mov BYTE PTR [rsp+7], 0x30
                mov BYTE PTR [rsp+8], 0x20
                mov BYTE PTR [rsp+9], 0x32
                mov BYTE PTR [rsp+10], 0x30
                mov BYTE PTR [rsp+11], 0x30
                mov BYTE PTR [rsp+12], 0x20
                mov BYTE PTR [rsp+13], 0x4F
                mov BYTE PTR [rsp+14], 0x4B
                mov BYTE PTR [rsp+15], 0x0D
                mov BYTE PTR [rsp+16], 0x0A
                mov BYTE PTR [rsp+17], 0x0D
                mov BYTE PTR [rsp+18], 0x0A
	mov rsi,rsp
	mov rdx,19
	syscall
	#close
	mov rax,3
	syscall

end:
        mov rax,60
        mov rdi,0
        syscall

