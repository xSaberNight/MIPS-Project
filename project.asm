################################################################################			
# Sample test run:			
##################			
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
################################################################################			
# int GetOneIntByVal(const char vtdPrompt[]);			
# void GetOneIntByAddr(int* intVarToPutInPtr,const char prompt[]);			
# void GetOneCharByAddr(char* charVarToPutInPtr, const char prompt[]);			
# void ValidateInt(int* givenIntPtr, int minInt, int maxInt, const char msg[]);			
# void SwapTwoInts(int* intPtr1, int* intPtr2);			
# void ShowIntArray(const int array[], int size, const char label[]);			
# 			
#int main()			
#{			
		.text	
		.globl main	
main:			
#   int intArr[7];			
#   int valsToDo;			
#   char reply;			
#   char vtdPrompt[] = "vals to do? ";			
#   char entIntPrompt[] = "enter some int: ";			
#   char adjMsg[] = " is bad, make it ";			
#   char origLab[] = "original:\n";			
#   char backLab[] = "backward:\n";			
#   char dmPrompt[] = "do more? ";			
#   int i, j;			
#################			
# Register Usage:			
#################			
# $t0: register holder for a value			
# $t1: i			
# $t2: j			
#################			
		addiu $sp, $sp, -114	
		j StrInitCode	# clutter-reduction jump (string initialization)
endStrInit:			
#   do			
#   {			
begWBodyM1:			
		li $a0, '\n'	
		li $v0, 11	
		syscall	# '\n' to offset effects of syscall #12 drawback
#      valsToDo = GetOneIntByVal(vtdPrompt);			
			
####################(3)####################			
		addi $a0, $sp, -55           
		jal GetOneIntByVal          
		sw $v0, -78($sp)           
# 		  BREAK			  #
		
#      ValidateInt(&valsToDo, 1, 7, adjMsg);			
			
####################(4)####################			
		addi $a0, $sp, -78       
		li $a1, 1                   
		li $a2, 7                   
		addi $a3, $sp, -11           
		jal ValidateInt
# 		  BREAK			  #        
        
#      for (i = valsToDo; i > 0; --i)			
			
####################(1)####################			
		lw $t1, -78($sp)       	
			
		j FTestM1	
begFBodyM1:			
#         if (i % 2) // i is odd			
		andi $t0, $t1, 0x00000001	
		beqz $t0, ElseI1	
#            intArr[valsToDo - i] = GetOneIntByVal(entIntPrompt);			
			
####################(8)####################			
    		lw $t2, -78($sp)           # Load valsToDo into $t2
		sub $t2, $t2, $t1          # t2 = valsToDo - i
		sll $t2, $t2, 2            # t2 = (valsToDo - i) * 4

		addiu $t3, $sp, -84        # Base address of intArr
		add $t3, $t3, $t2          # Address of intArr[valsToDo - i]

		addi $a0, $sp, -29          # Address of entIntPrompt
		jal GetOneIntByVal         # Call GetOneIntByVal

		sw $v0, 0($t3)             # Store result in intArr[valsToDo - i]   
# 		  BREAK			  #		
		
		
			
		j endI1	
#         else // i is even			
ElseI1:			
#            GetOneIntByAddr(intArr + valsToDo - i, entIntPrompt);			
			
####################(7)####################			
		lw $t2, -78($sp)       
    		sub $t2, $t2, $t1       
    		sll $t2, $t2, 2         

    		addiu $t3, $sp, -84   
    		add $a0, $t3, $t2       

    		addi $a1, $sp, -29      

    		jal GetOneIntByAddr
# 		  BREAK			  #		
		
		
		
			
endI1:			
		addi $t1, $t1, -1	
FTestM1:			
		bgtz $t1, begFBodyM1 	
#      ShowIntArray(intArr, valsToDo, origLab);			
			
####################(3)####################			
    		addi $a0, $sp, -84        # Address of intArr (base address of the array)
		lw $a1, -78($sp)          # Load valsToDo into $a1 (size of the array)
		addi $a2, $sp, -44        # Address of origLab (label for output)

		jal ShowIntArray          # Call ShowIntArray	
# 		  BREAK			  #
			
#      for (i = 0, j = valsToDo - 1; i < j; ++i, --j)			
####################(3)####################			
    		li $t1, 0              
    		lw $t2, -78($sp)       
    		addi $t2, $t2, -1       
		
		
			
		j FTestM2	
# 		  BREAK			  #		

begFBodyM2:			
#         SwapTwoInts(intArr + i, intArr + j);			
			
####################(5)####################			
    		sll $t3, $t1, 2           # Calculate offset for i (i * 4)
		addiu $t4, $sp, -84        # Base address of intArr
		add $a0, $t4, $t3          # Address of intArr[i]

		sll $t3, $t2, 2           # Calculate offset for j (j * 4)
		add $a1, $t4, $t3          # Address of intArr[j]

		jal SwapTwoInts            # Call SwapTwoInts	
# 		  BREAK			  #
			
		addi $t1, $t1, 1	
		addi $t2, $t2, -1	
FTestM2:			
		blt $t1, $t2, begFBodyM2	
#      ShowIntArray(intArr, valsToDo, backLab);			
			
####################(3)####################			
		addi $a0, $sp, -84        # Address of intArr (base address of the array)
		lw $a1, -78($sp)          # Load valsToDo into $a1 (size of the array)
		addi $a2, $sp, 0          # Address of backLab (label for output)

		jal ShowIntArray          # Call ShowIntArray	
# 		  BREAK			  #
			
#      GetOneCharByAddr(&reply, dmPrompt);			
			
####################(2)####################			
    		addi $a0, $sp, -110       # Address of reply
		addi $a1, $sp, -68        # Address of dmPrompt

		jal GetOneCharByAddr      # Call GetOneCharByAddr
# 		  BREAK			  #
	
#   }			
#   while (reply != 'n' && reply != 'N');			
			
####################(1)####################			
    		lb $v1, -110($sp)       
# 		  BREAK			  #    				
			
		li $t0, 'n'	
		beq $v1, $t0, endWhileM1	
		li $t0, 'N'	
		bne $v1, $t0, begWBodyM1	
endWhileM1: 	# extra helper label added		
			
#   return 0;			
#}			
		addiu $sp, $sp, 114	
		li $v0, 10	
		syscall	
			
################################################################################			
#int GetOneIntByVal(const char prompt[])			
#{			
GetOneIntByVal:			
#   int oneInt;			
#   cout << prompt;			
		li $v0, 4	
		syscall	
#   cin >> oneInt;			
		li $v0, 5	
		syscall	
#   return oneInt;			
#}			
		jr $ra	
			
################################################################################			
#void GetOneIntByAddr(int* intVarToPutInPtr, const char prompt[])			
#{			
GetOneIntByAddr:			
#   cout << prompt;			
		move $t0, $a0	# $t0 has saved copy of $a0 as received
		move $a0, $a1	
		li $v0, 4	
		syscall	
#   cin >> *intVarToPutInPtr;			
		li $v0, 5	
		syscall	
		sw $v0, 0($t0)	
#}			
		jr $ra	
			
################################################################################			
#void ValidateInt(int* givenIntPtr, int minInt, int maxInt, const char msg[])			
#{			
ValidateInt:			
#################			
# Register Usage:			
#################			
# $t0: copy of arg1 ($a0) as received			
# $v1: value loaded from mem (*givenIntPtr)			
#################			
		move $t0, $a0	# $t0 has saved copy of $a0 as received
#   if (*givenIntPtr < minInt) 			
#   {			
		lw $v1, 0($t0)	# $v1 has *givenIntPtr
		bge $v1, $a1, ElseVI1	
#      cout << *givenIntPtr << msg << minInt << endl;			
		move $a0, $v1	
		li $v0, 1	
		syscall	
		move $a0, $a3	
		li $v0, 4	
		syscall	
		move $a0, $a1	
		li $v0, 1	
		syscall	
		li $a0, '\n'	
		li $v0, 11	
		syscall	
#      *givenIntPtr = minInt;			
		sw $a1, 0($t0)	
		j endIfVI1	
#   }			
#   else 			
#   {			
ElseVI1:			
#      if (*givenIntPtr > maxInt) 			
#      {			
		ble $v1, $a2, endIfVI2	
#         cout << *givenIntPtr << msg << maxInt << endl;			
		move $a0, $v1	
		li $v0, 1	
		syscall	
		move $a0, $a3	
		li $v0, 4	
		syscall	
		move $a0, $a2	
		li $v0, 1	
		syscall	
		li $a0, '\n'	
		li $v0, 11	
		syscall	
#         *givenIntPtr = maxInt;			
		sw $a2, 0($t0)	
#      }			
endIfVI2:			
#   }			
endIfVI1:			
#}			
		jr $ra	
			
################################################################################			
#void ShowIntArray(const int array[], int size, const char label[])			
#{			
ShowIntArray:			
#################			
# Register Usage:			
#################			
# $t0: copy of arg1 ($a0) as received			
# $a3: k			
# $v1: value loaded from mem (*givenIntPtr)			
#################			
		move $t0, $a0	# $t0 has saved copy of $a0 as received
#   cout << label;			
		move $a0, $a2	
		li $v0, 4	
		syscall	
#   int k = size;			
		move $a3, $a1	
		j WTestSIA	
#   while (k > 0)			
#   {			
begWBodySIA:			
#      cout << array[size - k] << ' ';			
		sub $v1, $a1, $a3	# $v1 gets (size - k)
		sll $v1, $v1, 2	# $v1 now has 4*(size - k)
		add $v1, $v1, $t0	# $v1 now has &array[size - k]
		lw $a0, 0($v1)	# $a0 has array[size - k]
		li $v0, 1	
		syscall	
		li $a0, ' '	
		li $v0, 11	
		syscall	
#      --k;			
		addi $a3, $a3, -1	
#   }			
WTestSIA:			
		bgtz $a3, begWBodySIA	
#   cout << endl;			
		li $a0, '\n'	
		li $v0, 11	
		syscall	
#}			
		jr $ra	
			
################################################################################			
#void SwapTwoInts(int* intPtr1, int* intPtr2)			
#{			
SwapTwoInts:			
#################			
# Register Usage:			
#################			
# (fill in where applicable)			
#################			
#   int temp = *intPtr1;			
#  *intPtr1 = *intPtr2;			
#   *intPtr2 = temp;			
			
####################(4)####################			
    		lw $t0, 0($a0)        
    		lw $t1, 0($a1)       
    		sw $t1, 0($a0)        
   		sw $t0, 0($a1)        
# 		  BREAK			  #		
		
		
		
#			
		jr $ra	
			
################################################################################			
#void GetOneCharByAddr(char* charVarToPutInPtr, const char prompt[])			
#{			
GetOneCharByAddr:			
#################			
# Register Usage:			
#################			
# (fill in where applicable)			
#################			
#   cout << prompt;			
#   cin >> *charVarToPutInPtr;			
			
####################(7)####################			
    		move $a0, $a1          
    		li $v0, 4              
    		syscall

    		li $v0, 12             
    		syscall

    		sb $v0, 0($a0)        
# 		  BREAK			  #		
		
		
		
		
		
		
#}			
		jr $ra	
			
################################################################################			
StrInitCode:			
#################			
# "bulky & boring" string-initializing code move off of main stage			
################################################################################			
		li $t0, 'b'		
		sb $t0, 0($sp)	
		li $t0, 'a'		
		sb $t0, 1($sp)	
		li $t0, 'c'		
		sb $t0, 2($sp)	
		li $t0, 'k'		
		sb $t0, 3($sp)	
		li $t0, 'w'		
		sb $t0, 4($sp)	
		li $t0, 'a'		
		sb $t0, 5($sp)	
		li $t0, 'r'		
		sb $t0, 6($sp)	
		li $t0, 'd'		
		sb $t0, 7($sp)	
		li $t0, ':'		
		sb $t0, 8($sp)	
		li $t0, '\n'		
		sb $t0, 9($sp)	
		li $t0, '\0'		
		sb $t0, 10($sp)	
#############			
		li $t0, 'e'		
		sb $t0, 29($sp)	
		li $t0, 'n'		
		sb $t0, 30($sp)	
		li $t0, 't'		
		sb $t0, 31($sp)	
		li $t0, 'e'		
		sb $t0, 32($sp)	
		li $t0, 'r'		
		sb $t0, 33($sp)	
		li $t0, ' '		
		sb $t0, 34($sp)	
		li $t0, 'a'		
		sb $t0, 35($sp)	
		li $t0, 'n'		
		sb $t0, 36($sp)	
		li $t0, ' '		
		sb $t0, 37($sp)	
		li $t0, 'i'		
		sb $t0, 38($sp)	
		li $t0, 'n'		
		sb $t0, 39($sp)	
		li $t0, 't'		
		sb $t0, 40($sp)	
		li $t0, ':'		
		sb $t0, 41($sp)	
		li $t0, ' '		
		sb $t0, 42($sp)	
		li $t0, '\0'		
		sb $t0, 43($sp)	
#############			
		li $t0, ' '		
		sb $t0, 11($sp)	
		li $t0, 'i'		
		sb $t0, 12($sp)	
		li $t0, 's'		
		sb $t0, 13($sp)	
		li $t0, ' '		
		sb $t0, 14($sp)	
		li $t0, 'b'		
		sb $t0, 15($sp)	
		li $t0, 'a'		
		sb $t0, 16($sp)	
		li $t0, 'd'		
		sb $t0, 17($sp)	
		li $t0, ','		
		sb $t0, 18($sp)	
		li $t0, ' '		
		sb $t0, 19($sp)	
		li $t0, 'm'		
		sb $t0, 20($sp)	
		li $t0, 'a'		
		sb $t0, 21($sp)	
		li $t0, 'k'		
		sb $t0, 22($sp)	
		li $t0, 'e'		
		sb $t0, 23($sp)	
		li $t0, ' '		
		sb $t0, 24($sp)	
		li $t0, 'i'		
		sb $t0, 25($sp)	
		li $t0, 't'		
		sb $t0, 26($sp)	
		li $t0, ' '		
		sb $t0, 27($sp)	
		li $t0, '\0'		
		sb $t0, 28($sp)	
#############			
		li $t0, 'o'		
		sb $t0, 44($sp)	
		li $t0, 'r'		
		sb $t0, 45($sp)	
		li $t0, 'i'		
		sb $t0, 46($sp)	
		li $t0, 'g'		
		sb $t0, 47($sp)	
		li $t0, 'i'		
		sb $t0, 48($sp)	
		li $t0, 'n'		
		sb $t0, 49($sp)	
		li $t0, 'a'		
		sb $t0, 50($sp)	
		li $t0, 'l'		
		sb $t0, 51($sp)	
		li $t0, ':'		
		sb $t0, 52($sp)	
		li $t0, '\n'		
		sb $t0, 53($sp)	
		li $t0, '\0'		
		sb $t0, 54($sp)	
#############			
		li $t0, 'v'		
		sb $t0, 55($sp)	
		li $t0, 'a'		
		sb $t0, 56($sp)	
		li $t0, 'l'		
		sb $t0, 57($sp)	
		li $t0, 's'		
		sb $t0, 58($sp)	
		li $t0, ' '		
		sb $t0, 59($sp)	
		li $t0, 't'		
		sb $t0, 60($sp)	
		li $t0, 'o'		
		sb $t0, 61($sp)	
		li $t0, ' '		
		sb $t0, 62($sp)	
		li $t0, 'd'		
		sb $t0, 63($sp)	
		li $t0, 'o'		
		sb $t0, 64($sp)	
		li $t0, '?'		
		sb $t0, 65($sp)	
		li $t0, ' '		
		sb $t0, 66($sp)	
		li $t0, '\0'		
		sb $t0, 67($sp)
#############
		li $t0, 'd'
		sb $t0, 68($sp)	
		li $t0, 'o'		
		sb $t0, 69($sp)	
		li $t0, ' '		
		sb $t0, 70($sp)	
		li $t0, 'm'		
		sb $t0, 71($sp)	
		li $t0, 'o'		
		sb $t0, 72($sp)	
		li $t0, 'r'		
		sb $t0, 73($sp)	
		li $t0, 'e'		
		sb $t0, 74($sp)	
		li $t0, '?'		
		sb $t0, 75($sp)	
		li $t0, ' '		
		sb $t0, 76($sp)	
		li $t0, '\0'		
		sb $t0, 77($sp)	
		
	j endStrInit
