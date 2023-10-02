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

.macro PRINT_INT
	li a7, 1
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
	matrixspace: .string "	"

.text   
	PRINT_STRING input_row
	GET_INT
	mv t0, a0
	PRINT_STRING input_column
	GET_INT
	mv t1, a0
	
	mul t2, t0, t1 # matrix size, row (t0) * column (t1)
	
	# Initialize elements counter
	li t3, 0
	li x3, 0
	li s3, 0
	
	# Load matrix address
	la t4, matrix
	
	# Matrix size * 4 bytes (interval)
	li x4, 4
	
	PRINT_STRING elements
	NEWLINE
	
	input_loop:
		beq t3, t2, loop_offset

		GET_FLOAT
		
		fsw fa0, 0(t4)
		
		add t4, t4, x4
		addi t3, t3, 1
		
		j input_loop
		
	loop_offset:
		beq s3, t3, print_loop
		
		sub t4, t4, x4
		addi s3, s3, 1
		
		j loop_offset
		
	print_loop:
		beq x3, t2, done
		
		addi x1, x3, 1
		rem x2, x1, t1
		
		flw fa0, 0(t4)
		PRINT_FLOAT
		
		add t4, t4, x4
		addi x3, x3, 1
		
		beq x2, zero, print_newline
		PRINT_STRING matrixspace
		
		j print_loop
	
	print_newline:
		NEWLINE
		j print_loop
	
	done:
		
		li a7, 10
		ecall
