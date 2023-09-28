.section .data

input_x_prompt	:	.asciz	"Please enter x: "
input_y_prompt	:	.asciz	"Please enter y: "
input_spec	:	.asciz	"%d"
result		:	.asciz	"x * y = %d\n"

.section .text

.global main

# main
main:

# create room on stack for x and y
sub sp, sp, 8
# input x prompt
ldr x0, = input_x_prompt
bl printf	
# get input x value
# spec input
ldr x0, = input_spec
mov x1, sp
bl scanf
ldrsw x19, [sp]


# input y prompt
ldr x0, = input_y_prompt
bl printf
# get input y value
# spec input
ldr x0, = input_spec
mov x1, sp
bl scanf
ldrsw x20, [sp]

# set x21 to 0
mov x21, 0

# multiply x and y
recmul:
	cmp x20, 0
	b.eq exit
	add x21, x21, x19
	sub x20, x20, 1
	b recmul

# branch to this label on program completion
exit:
	mov x1, x21
	ldr x0, =result
	bl printf
	mov x0, 0
	mov x8, 93
	svc 0
	ret

