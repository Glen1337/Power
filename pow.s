.text
.globl pow
.type pow, @function

pow:
	pushl %ebp		#store ebp
	movl %esp, %ebp		#make new ebp point to old ebp
	pushl %ebx		#store ebx - callee save
	pushl %esi		#store esi - callee save
	pushl %edi		#store edi - callee save

	movl 8(%ebp), %eax	#put x into eax
	movl 12(%ebp), %edx	#put y into edx
	movl %eax, %esi		#copy x into esi
	movl $1, %eax		#put 1(result) into eax
	cmpl $0, %esi		#if x is 0, jump to .x_0 to return 0
	je .x_0			#jump to .x-0
	cmpl $0, %edx		#if y is 0, jump to .y_0 to return 1
	je .y_0			#jump to .y_0
.LOOP:
	imull %esi, %eax	#multiply result * x
	subl $1, %edx		#decrement y
	jg .LOOP		#if y is greater than 1, goto .LOOP
	jmp .DONE		#if y is not greater than 1, goto .DONE
.x_0:
	movl $0, %eax		#if x is 0, result is 0
	jmp .DONE		#done
.y_0:
	movl $1, %eax		#if y is 0, result is 1, done
.DONE:
	popl %edi		#restore edi - callee save
	popl %esi		#restore esi - callee save
	popl %ebx		#restore ebx - callee save
	leave			#reset esp and ebp
	ret			#return address
