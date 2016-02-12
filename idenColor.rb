
$iden = Hash.new

$iden_kind = ["Terminator", "Binary", "Bitwise", "Vector", "Aggregate", "Memory", "Conversion", "Other"] 

def check? (token:"none")
  # print "check #{token}\n"
  for key in $iden_kind do
    # p key
    return true if $iden[key].has_key?(token)
  end
  return false
end

def setcolor (token:"none")
  # print "check #{token}\n"
  for key in $iden_kind do
    return $iden[key][token] if $iden[key].has_key?(token)
  end
  return nil
end

for var in $iden_kind do
  $iden[var] = Hash.new
end

# p $iden

#Terminator Instructions
$Terminator = Array.new;
$Terminator << "Terminator"
$Terminator << "ret"
$Terminator << "switch"
$Terminator << "br"
$Terminator << "indirectbr"
$Terminator << "invoke"
$Terminator << "resume"
$Terminator << "catchpad"
$Terminator << "catchendpad"
$Terminator << "catchret"
$Terminator << "cleanupendpad"
$Terminator << "cleanupret"
$Terminator << "terminatepad"
$Terminator << "unreachable"
# p $Terminator["ret"]

# Binary Operations
$Binary = Array.new;
$Binary << "Binary"
$Binary << "add"
$Binary << "fadd"
$Binary << "sub"
$Binary << "fsub"
$Binary << "mul"
$Binary << "fmul"
$Binary << "udiv"
$Binary << "sdiv"
$Binary << "fdiv"
$Binary << "urem"
$Binary << "srem"
$Binary << "frem"

# Bitwise Binary Operations
$Bitwise = Array.new
$Bitwise << "Bitwise"
$Bitwise << "shl"
$Bitwise << "lshr"
$Bitwise << "ashr"
$Bitwise << "and"
$Bitwise << "or"
$Bitwise << "xor"

# Vector Operations
$Vector = Array.new
$Vector << "Vector"
$Vector << "extractelement"
$Vector << "insertelement"
$Vector << "shufflevector"


# Aggregate Operations
$Aggregate = Array.new
$Aggregate << "Aggregate"
$Aggregate << "extractvalue"
$Aggregate << "insertvalue"
$Aggregate << "insertvalue"

#Memory Access and Addressing Operations
$Memory = Array.new 
$Memory << "Memory"
$Memory << "alloca"
$Memory << "load"
$Memory << "store"
$Memory << "fence"
$Memory << "cmpxchg"
$Memory << "atomicrmw"
$Memory << "getelementptr"

# Conversion Operations
$Conversion = Array.new
$Conversion << "Conversion" #to
$Conversion << "trunc" #to
$Conversion << "zext" #to
$Conversion << "sext" #to
$Conversion << "fptrunc" #to
$Conversion << "fpext" #to
$Conversion << "fptoui" #to
$Conversion << "fptosi" #to
$Conversion << "uitofp" #to
$Conversion << "sitofp" #to
$Conversion << "ptrtoint" #to
$Conversion << "inttoptr" #to
$Conversion << "bitcast" #to
$Conversion << "addrspacecast" #to

# Other Operations
$Other = Array.new
$Other << "Other"
$Other << "icmp"
$Other << "fcmp"
$Other << "phi"
$Other << "select"
$Other << "call"
$Other << "va_arg"
$Other << "landingpad"
$Other << "cleanuppad"

def store_iden(kind:"Other", iden:"iden", color_value:1)
  $iden[kind][iden] = color_value
end

for i in 1..$Terminator.count-1 do 
  store_iden(kind:$Terminator[0], iden:$Terminator[i], color_value:30)
end
for i in 1..$Binary.count-1 do 
  store_iden(kind:$Binary[0], iden:$Binary[i], color_value:31)
end
for i in 1..$Bitwise.count-1 do 
  store_iden(kind:$Bitwise[0], iden:$Bitwise[i], color_value:32)
end
for i in 1..$Terminator.count-1 do 
  store_iden(kind:$Vector[0], iden:$Vector[i], color_value:33)
end
for i in 1..$Aggregate.count-1 do 
  store_iden(kind:$Aggregate[0], iden:$Aggregate[i], color_value:34)
end
for i in 1..$Memory.count-1 do 
  store_iden(kind:$Memory[0], iden:$Memory[i], color_value:nil)
end
for i in 1..$Conversion.count-1 do 
  store_iden(kind:$Conversion[0], iden:$Conversion[i], color_value:36)
end
for i in 1..$Other.count-1 do 
  store_iden(kind:$Other[0], iden:$Other[i], color_value:35)
end
