addi $1, $0, 5                  # 00
addi $2, $0, 10                 # 02
sw $1, 2($0)                    # 04
sw $2, 4($0)                    # 06
add $3, $1, $2                  # 08
sub $4, $2, $1                  # 10
and $5, $0, $1                  # 12
or $6, $0, $1                   # 14
slt $1, $0, $1                  # 16
slti $2, $1, 15                 # 18
beq $0, $1, equal               # 20
jal function                    # 22
j end                           # 24
equal:addi $6, $0, 0            # 26
j end                           # 28
function: lw $1, 2($0)          # 30
lw $2, 4($0)                    # 32
jr $7                           # 34
end: nop                        # 36
