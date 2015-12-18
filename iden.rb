# 予約命令
$iden = Array.new;
# $iden << "define"

#Terminator Instructions
# $iden << "ret"
$iden << "switch"
# $iden << "br"
$iden << "indirectbr"
$iden << "invoke"
$iden << "resume"
$iden << "catchpad"
$iden << "catchendpad"
$iden << "catchret"
$iden << "cleanupendpad"
$iden << "cleanupret"
$iden << "terminatepad"
$iden << "unreachable"

# Binary Operations
$iden << "add"
$iden << "fadd"
$iden << "sub"
$iden << "fsub"
$iden << "mul"
$iden << "fmul"
$iden << "udiv"
$iden << "sdiv"
$iden << "fdiv"
$iden << "urem"
$iden << "srem"
$iden << "frem"

# Bitwise Binary Operations
$iden << "shl"
$iden << "lshr"
$iden << "ashr"
$iden << "and"
$iden << "or"
$iden << "xor"

# Vector Operations
$iden << "extractelement"
$iden << "insertelement"
$iden << "shufflevector"

# Aggregate Operations
$iden << "extractvalue"
$iden << "insertvalue"
$iden << "insertvalue"

#Memory Access and Addressing Operations
# $iden << "alloca"
$iden << "load"
$iden << "store"
$iden << "fence"
$iden << "cmpxchg"
$iden << "atomicrmw"
$iden << "getelementptr"

# Conversion Operations
$iden << "trunc" #to
$iden << "zext" #to
$iden << "sext" #to
$iden << "fptrunc" #to
$iden << "fpext" #to
$iden << "fptoui" #to
$iden << "fptosi" #to
$iden << "uitofp" #to
$iden << "sitofp" #to
$iden << "ptrtoint" #to
$iden << "inttoptr" #to
$iden << "bitcast" #to
$iden << "addrspacecast" #to
  
# Other Operations
$iden << "icmp"
$iden << "fcmp"
$iden << "phi"
$iden << "select"
$iden << "call"
$iden << "va_arg"
$iden << "landingpad"
$iden << "cleanuppad"

