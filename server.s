.comm fpath,64,2048
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
        add rsp,16
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

        mov r9,rdi #store accepted socket for later use

        #parse request path
        mov r10,rsp
        call path

        add rsp,2048

        #open file
        mov rdi,offset fpath
        mov rdx,0
        mov rsi,0000000
        mov rax,2
        syscall
        mov r8,rax #file fd

        #read file into stack
        mov rdi,rax
        mov rax,0
        mov rsi,offset content
        mov rdx,2048
        syscall
        mov r12,rax #file length

        #close fd from requested file
        #close fd
        mov rdi,r8
        mov rax,3
        syscall

        #write ok into socket
        mov rax,1
        mov rsi,offset OK
        mov rdi,r9
        mov rdx,19
        syscall

        #write file into socket
        mov rdx,r12
        mov rsi,offset content
        mov rax,1
        mov rdi,r9
        syscall


end:
        #close socket fd
        mov rax,3
        mov rdi,r9
        syscall

        mov rax,60
        mov rdi,0
        syscall


path:
        #get the requested path
        #remove verb
        mov ecx, 2048
        mov rdi,r10
        mov al, ' '
        cld
        repne scasb
        mov ecx,2048
        mov rax,0
        #store path into buffer
        file:
                cmp BYTE PTR [rdi+rax],' ' 
                je cleanup
                mov dl,BYTE PTR [rdi+rax]
                mov BYTE PTR[offset fpath+rax],dl
                inc rax
                jmp file
        cleanup:
                ret

.data
   OK: .ascii "HTTP/1.0 200 OK\r\n\r\n"
   content: .ascii ""
