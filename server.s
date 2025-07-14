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

response:
	#accept http request
	mov rax,43
	mov rsi,0
	mov rdx,0
	syscall
	mov rdi,rax

	#read http request
	mov rax,0
	sub rsp,2048
	mov rsi,rsp
	mov rdx,2048
	syscall
	
	#parse request
	mov r10,rsp
	sub rsp,2048
	call parse

	#response
	mov rax,1
	sub rsp,19 #HTTP/1.0 200 OK
                mov BYTE PTR [rsp], 0x48
	mov rsi,rsp
	mov rdx,19
	syscall
	
	#close fd
	mov rax,3
	syscall

end:
	int3
        mov rax,60
        mov rdi,0
        syscall


parse:	
	#get the requested path
	mov ecx, 2048
	mov rdi,r10
	mov al, 'f'
	cld
	repne scasb
	int3
	je end
	#jump to method handler
	#cmp BYTE PTR[rax],'G'
	#je get
	#cmp BYTE PTR[rax],'P'
	#je post
	#jmp end
