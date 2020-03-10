		#s0 ->head
		#s1 ->tail
.data

message: .asciz "insert a number >0\n"
message2: .asciz "insert a number >=0\n"
.text

main:
	#alocate dummy pointer
	jal ra,node_alloc #call node_alloc()
	
	sw zero,0(a0)# dummy->data=0
	sw zero , 4(a0) #dummy->ptr=0
	
	#init s0 and s1
	addi s0 , a0 , 	0
	addi s1 , a0 ,  0
#loop:	#WHILE LOOP
	addi x17, x0, 4 # environment call code for print_string
 	la x10, message # pseudo-instruction: address of string
 	ecall 
	jal ra,read_int#call read_int()
	
	
 loop:	bge x0, a0, after_loop
 	addi t1,a0,0#t1=intiger
 	jal ra,node_alloc #call node_alloc()	
	sw t1,0(a0)#p->data=input
	sw zero ,4(a0)#p->next=0
	sw a0, 4(s1)	#tail->next = p
	add s1,a0,x0 #tail=p
 	
 	addi x17, x0, 4 # environment call code for print_string
 	la x10, message # pseudo-instruction: address of string
 	ecall 
 	
 	jal ra,read_int#call read_int()
 	
 	j loop
 	
after_loop:
	addi x17, x0, 4 # environment call code for print_string
 	la x10, message2 # pseudo-instruction: address of string
 	ecall 
	jal ra,read_int#call read_int()
 	
 	add s1,zero ,a0 
if: 	bge s1, x0, then
	
	#exit
	addi a7,zero,10
	ecall
	
then:
	add s2,s0,zero		#s2=head
	lw t1,0(s2)
	lw t2,4(s2)
	
	
loop2:  beq t2,x0,after_loop2
	#iterate the list
	lw t1,0(s2)
	lw t2,4(s2)
	#lw t2, 0(s1)
if2: 	bgt  t1 ,s1,then2 
	j test

then2:	
	#print intiger
	addi x17, x0, 1 # environment call code for print_intiger
	lw t3,0(s2)
	add a0 ,zero,t3
	
 	ecall 
 	j test
	
	
test: 
	#lw t4,4(s2)
	#add s2,t4,zero #p=p->next
	lw s2, 4(s2)
	j loop2
after_loop2:

	j after_loop

read_int:
	addi a7,x0,5 #read intiger
 	ecall 
	jr ra
	
node_alloc:
	#allocate memory
 	addi a7,zero ,9
	addi a0,zero,8
	ecall
	jr ra





	
