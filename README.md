# MIPS-Project
# NOTES:			
# - "does not require local storage" means each (leaf) function			
#   -- does not need memory on the stack for local variables (including arrays)			
#   -- WILL NOT use any callee-saved registers ($s0 through $s7)			
# - meant as an exercise for familiarizing w/ the			
#   -- basics of MIPS' function-call mechanism			
#   -- how-to's of pass-by-value & pass-by-address when doing functions in MIPS			
# - does NOT adhere to more-broadly-applicable function-call convention (which			
#   is needed when doing functions in general, not just "trivial" functions)			
# - main (being the only non-"trivial" function & an unavoidable one) will in 			
#   fact violate the yet-to-be-studied(?) function-call convention			
#   -- due to this, each of the functions that main calls MUST TAKE ANOMALOUS 			
#      CARE not to "clobber" the contents of registers that main uses & expects			
#      to be preserved across calls			
#   -- experiencing the pains and appreciating the undesirability of having to			
#      deal with the ANOMALOUS SITUATION (due to the non-observance of any			
#      function-call convention that governs caller-callee relationship) should			
#      help in understanding why some function-call convention must be defined			
#      and observed	


# ●	Each hole that you must fill is indicated by a comment line that looks like:
# ####################(4)####################
# I have added a '# 		  BREAK			  #' following each group of statements
# Only the code between the hole and the '# 		  BREAK			  #' is allowed to be  altered


# The number within the parentheses indicates the number of statements used 


# Error I have been receiving with the current program status:
# line 280: Runtime exception at 0x00400130: invalid integer input (syscall 5)


# Output I am receiving:
# backward:
# 2
# to do? 2
# t: 2 2 
# al:
# 2 2 
# to do? 2
# backward:


# EXPECTED Output:
# 			
# vals to do? 4			
# enter an int: 1			
# enter an int: 2			
# enter an int: 3			
# enter an int: 4			
# original:			
# 1 2 3 4 			
# backward:			
# 4 3 2 1 			
# do more? y			
# vals to do? 0			
# 0 is bad, make it 1			
# enter an int: 5			
# original:			
# 5 			
# backward:			
# 5 			
# do more? y			
# vals to do? 8			
# 8 is bad, make it 7			
# enter an int: 7			
# enter an int: 6			
# enter an int: 5			
# enter an int: 4			
# enter an int: 3			
# enter an int: 2			
# enter an int: 1			
# original:			
# 7 6 5 4 3 2 1 			
# backward:			
# 1 2 3 4 5 6 7 			
# do more? n			
# -- program is finished running --		