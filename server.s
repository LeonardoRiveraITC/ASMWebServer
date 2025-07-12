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
	mov rsi,10
	syscall

end:
	mov rax,60
	mov rdi,0
	syscall
