.intel_syntax noprefix
.global _start
_start:
	mov rax,41
	mov rdi,2 #AF_INET
	mov rdx,1 #SOCK_STREAM
	mov rdx,0
	syscall
end:
	mov rax,60
	mov rdi,0
	syscall
