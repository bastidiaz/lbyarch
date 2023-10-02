.macro NEWLINE 
	li a0, 10   
	li a7, 11   
	ecall   
.end_macro   

.macro PRINT_STRING (%x)    
	li a7, 4   
	la a0, %x   
	ecall   
.end_macro   

.macro PRINT_FLOAT 
	li a7, 2 
	ecall 
.end_macro

.macro GET_FLOAT 
	li a7, 6 
	ecall  
.end_macro

.macro GET_INT
	li a7, 5
	ecall
.end_macro

.data   
	input_row: .string "Row size:	"
	input_column: .string "Column size:	"
	elements: .string "Elements:	"
	matrix: .space 1000
	matrixspace: .string " "

.text   
	PRINT_STRING input_row
	GET_INT
	mv t0, a0
	PRINT_STRING input_column
	GET_INT
	mv t1, a0
	mul t2, t0, t1
	
	addi x1, x1, 0
	
	# Initialize elements counter
	li t3, 0
	li x3, 0
	
	# Load matrix address
	la t4, matrix
	# lw x4, (t4)
	
	PRINT_STRING elements
	NEWLINE
	
	input_loop:
		beq t3, t2, print_loop

		GET_FLOAT
		
		fsw fa0, 0(t4)
		
		addi t4, t4, 4
		addi t3, t3, 1
		
		j input_loop
		
	print_loop:
		beq x3, t2, done
		
		addi x4, x3, 1
		rem x5, x4, t1
		
		flw fa0, -24(t4)
		PRINT_FLOAT
		
		addi t4, t4, 4
		addi x3, x3, 1
		
		beq x5, zero, print_newline
		PRINT_STRING matrixspace
		
		j print_loop
	
	print_newline:
		NEWLINE
		j print_loop
	
	done:
		
		li a7, 10
		ecall
