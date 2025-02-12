##############################################################
#Array
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Size of array
#   4 Bytes - Size of elements
##############################################################

##############################################################
#Linked List
##############################################################
#   4 Bytes - Address of the First Node
#   4 Bytes - Size of linked list
##############################################################

##############################################################
#Linked List Node
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Address of the Next Node
##############################################################

##############################################################
#Recipe
##############################################################
#   4 Bytes - Name (address of the name)
#	4 Bytes - Ingredients (address of the ingredients array)
#   4 Bytes - Cooking Time
#	4 Bytes - Difficulty
#	4 Bytes - Rating
##############################################################


.data
space: .asciiz " "
newLine: .asciiz "\n"
tab: .asciiz "\t"
lines: .asciiz "------------------------------------------------------------------\n"

listStr: .asciiz "List: \n"
recipeName: .asciiz "Recipe name: "
ingredients: .asciiz "Ingredients: "
cookingTime: .asciiz "Cooking time: "
difficulty: .asciiz "Difficulty: "
rating: .asciiz "Rating: "
listSize: .asciiz "List Size: "
emptyListWarning: .asciiz "List is empty!\n"
indexBoundWarning: .asciiz "Index out of bounds!\n"
recipeNotMatch: .asciiz "Recipe not matched!\n"
recipeMatch: .asciiz "Recipe matched!\n"
recipeAdded: .asciiz "Recipe added.\n"
recipeRemoved: .asciiz "Recipe removed.\n"
noRecipeWarning: .asciiz "No recipe to print!\n"



addressOfRecipeList: .word 0 #the address of the array of recipe list stored here!


# Recipe 1: Pancakes
r1: .asciiz "Pancakes"
r1i1: .asciiz "Flour"
r1i2: .asciiz "Milk"
r1i3: .asciiz "Eggs"
r1i4: .asciiz "Sugar"
r1i5: .asciiz "Baking powder"
r1c: .word 15							# Cooking time in minutes
r1d: .word 2							# Difficulty (scale 1-5)
r1r: .word 4							# Rating (scale 1-5)

# Recipe 2: Spaghetti Bolognese
r2: .asciiz "Spaghetti Bolognese"
r2i1: .asciiz "Spaghetti"
r2i2: .asciiz "Ground beef"
r2i3: .asciiz "Tomato sauce"
r2i4: .asciiz "Garlic"
r2i5: .asciiz "Onion"
r2c: .word 30
r2d: .word 3
r2r: .word 5

# Recipe 3: Chicken Stir-Fry
r3: .asciiz "Chicken Stir-Fry"
r3i1: .asciiz "Chicken breast"
r3i2: .asciiz "Soy sauce"
r3i3: .asciiz "Bell peppers"
r3i4: .asciiz "Broccoli"
r3i5: .asciiz "Garlic"
r3c: .word 20
r3d: .word 3
r3r: .word 4

# Recipe 4: Caesar Salad
r4: .asciiz "Caesar Salad"
r4i1: .asciiz "Romaine lettuce"
r4i2: .asciiz "Caesar dressing"
r4i3: .asciiz "Parmesan cheese"
r4i4: .asciiz "Croutons"
r4i5: .asciiz "Chicken breast (optional)"
r4c: .word 10
r4d: .word 1
r4r: .word 4

# Recipe 5: Chocolate Chip Cookies
r5: .asciiz "Chocolate Chip Cookies"
r5i1: .asciiz "Butter"
r5i2: .asciiz "Sugar"
r5i3: .asciiz "Flour"
r5i4: .asciiz "Eggs"
r5i5: .asciiz "Chocolate chips"
r5c: .word 25
r5d: .word 2
r5r: .word 5


search1: .asciiz "Caesar Salad"
search2: .asciiz "Shepherd's Pie"

.text 
main:


	#----------------------------------------------------------------------------------------
	jal createLinkedList
	move $t0, $v0  # $t0 address of the linked list
	la $a0, addressOfRecipeList
	sw $t0, 0($a0)
	

	li $a0, 5
	li $a1, 4
	jal createArray
	move $t1, $v0
	

	la $a1, r1i1
	li $a2, 0
	move $a0, $t1
	jal putElementToArray


	la $a1, r1i2
	li $a2, 1
	move $a0, $t1
	jal putElementToArray
	
	la $a1, r1i3
	li $a2, 2
	move $a0, $t1
	jal putElementToArray

	la $a1, r1i4
	li $a2, 3
	move $a0, $t1
	jal putElementToArray

	la $a1, r1i5
	li $a2, 4
	move $a0, $t1
	jal putElementToArray

	move $t1, $v0



	la $a0, r1           
	move $a1, $t1         
	lw $a2, r1c           
	lw $a3, r1d           
	lw $t2, r1r           
	sw $t2, 0($sp)        
	jal createRecipe
	move $t3, $v0


  
	lw $t0, addressOfRecipeList
	
	move $a0, $t0
	move $a1, $t3
	jal enqueue



#----------------------------------------------------------------------------------------
	#create spagethi bolognese

	li $a0, 5
	li $a1, 4
	jal createArray
	move $t1, $v0

	la $a1, r2i1
	li $a2, 0
	move $a0, $t1
	jal putElementToArray

	la $a1, r2i2
	li $a2, 1
	move $a0, $t1
	jal putElementToArray

	la $a1, r2i3
	li $a2, 2
	move $a0, $t1
	jal putElementToArray

	la $a1, r2i4
	li $a2, 3
	move $a0, $t1
	jal putElementToArray

	la $a1, r2i5
	li $a2, 4
	move $a0, $t1
	jal putElementToArray

	la $a0, r2 
	move $a1, $t1
	lw $a2, r2c
	lw $a3, r2d
	lw $t2, r2r
	sw $t2, 0($sp)
	jal createRecipe
	move $t3, $v0




	lw $t0, addressOfRecipeList
	
	move $a0, $t0
	move $a1, $t3
	jal enqueue



#----------------------------------------------------------------------------------------
	#print queue size

	lw $t0, addressOfRecipeList
	move $a0, $t0
	jal queueSize

	move $t0, $v0

	la $a0, listSize
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	# list:
	la $a0, listStr
	li $v0, 4
	syscall
	

	#new lines
	la $a0, lines
	li $v0, 4
	syscall
	
#----------------------------------------------------------------------------------------
	# traverse current list and print
	

	
	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, printRecipe
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall
	

#----------------------------------------------------------------------------------------
	#dequeue and print first recipe(pancakes)

	
	lw $t0, addressOfRecipeList   
	move $a0, $t0
	jal dequeue                   

	move $a0, $v0
	jal printRecipe

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	
#----------------------------------------------------------------------------------------
	#print queue size

	lw $t0, addressOfRecipeList
	move $a0, $t0
	jal queueSize

	move $t0, $v0

	la $a0, listSize
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	# list:
	la $a0, listStr
	li $v0, 4
	syscall
	
	#new lines
	la $a0, lines
	li $v0, 4
	syscall
	
	
#----------------------------------------------------------------------------------------
	# traverse current list and print
	
	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, printRecipe
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall
	
#----------------------------------------------------------------------------------------
	#dequeue and print second recipe(Spaghetti bolognese)

	
	lw $t0, addressOfRecipeList   
	move $a0, $t0
	jal dequeue                   

	move $a0, $v0
	jal printRecipe

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall
	


#----------------------------------------------------------------------------------------
	#dequeue and print second recipe(list is empty)

	
	lw $t0, addressOfRecipeList   
	move $a0, $t0
	jal dequeue                   

	move $a0, $v0


	jal printRecipe

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall
	

#----------------------------------------------------------------------------------------
	#print queue size

	lw $t0, addressOfRecipeList
	move $a0, $t0
	jal queueSize

	move $t0, $v0

	la $a0, listSize
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	# list:
	la $a0, listStr
	li $v0, 4
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

	
#----------------------------------------------------------------------------------------
	# traverse current list and print
	
	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, printRecipe
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

#----------------------------------------------------------------------------------------
	#create Chicken Stir-Fry Recipe

	li $a0, 5
	li $a1, 4
	jal createArray
	move $t1, $v0

	la $a1, r3i1
	li $a2, 0
	move $a0, $t1
	jal putElementToArray

	la $a1, r3i2
	li $a2, 1
	move $a0, $t1
	jal putElementToArray

	la $a1, r3i3
	li $a2, 2
	move $a0, $t1
	jal putElementToArray

	la $a1, r3i4
	li $a2, 3
	move $a0, $t1
	jal putElementToArray

	la $a1, r3i5
	li $a2, 4
	move $a0, $t1
	jal putElementToArray

	la $a0, r3
	move $a1, $t1
	lw $a2, r3c
	lw $a3, r3d
	lw $t2, r3r
	sw $t2, 0($sp)
	jal createRecipe
	move $t3, $v0


	lw $t0, addressOfRecipeList
	
	move $a0, $t0
	move $a1, $t3
	jal enqueue
	

#----------------------------------------------------------------------------------------
	#print queue size

	lw $t0, addressOfRecipeList
	move $a0, $t0
	jal queueSize

	move $t0, $v0

	la $a0, listSize
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	# list:
	la $a0, listStr
	li $v0, 4
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

#----------------------------------------------------------------------------------------
	# traverse current list and print
	
	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, printRecipe
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

#----------------------------------------------------------------------------------------
	#create Cesar Salad Recipe

	li $a0, 4
	li $a1, 4
	jal createArray
	move $t1, $v0

	la $a1, r4i1
	li $a2, 0
	move $a0, $t1
	jal putElementToArray

	la $a1, r4i2
	li $a2, 1
	move $a0, $t1
	jal putElementToArray

	la $a1, r4i3
	li $a2, 2
	move $a0, $t1
	jal putElementToArray

	la $a1, r4i4
	li $a2, 3
	move $a0, $t1
	jal putElementToArray


	la $a1, r4i5
	li $a2, 4
	move $a0, $t1
	jal putElementToArray



	la $a0, r4
	move $a1, $t1
	lw $a2, r4c
	lw $a3, r4d
	lw $t2, r4r
	sw $t2, 0($sp)
	jal createRecipe
	move $t3, $v0


	lw $t0, addressOfRecipeList
	
	move $a0, $t0
	move $a1, $t3
	jal enqueue

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall




#----------------------------------------------------------------------------------------
	#print queue size

	lw $t0, addressOfRecipeList
	move $a0, $t0
	jal queueSize

	move $t0, $v0

	la $a0, listSize
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	# list:
	la $a0, listStr
	li $v0, 4
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

#----------------------------------------------------------------------------------------
	# traverse current list and print
	
	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, printRecipe
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

#----------------------------------------------------------------------------------------
	#create Chocolate Chip Cookies 

	li $a0, 5
	li $a1, 4
	jal createArray
	move $t1, $v0

	la $a1, r5i1
	li $a2, 0
	move $a0, $t1
	jal putElementToArray

	la $a1, r5i2
	li $a2, 1
	move $a0, $t1
	jal putElementToArray

	la $a1, r5i3
	li $a2, 2
	move $a0, $t1
	jal putElementToArray

	la $a1, r5i4
	li $a2, 3
	move $a0, $t1
	jal putElementToArray


	la $a1, r5i5
	li $a2, 4
	move $a0, $t1
	jal putElementToArray



	la $a0, r5
	move $a1, $t1
	lw $a2, r5c
	lw $a3, r5d
	lw $t2, r5r
	sw $t2, 0($sp)
	jal createRecipe
	move $t3, $v0


	lw $t0, addressOfRecipeList
	
	move $a0, $t0
	move $a1, $t3
	jal enqueue

	
		

#----------------------------------------------------------------------------------------
	#print queue size

	lw $t0, addressOfRecipeList
	move $a0, $t0
	jal queueSize

	move $t0, $v0

	la $a0, listSize
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	# list:
	la $a0, listStr
	li $v0, 4
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

	
#----------------------------------------------------------------------------------------
	# traverse current list and print
	
	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, printRecipe
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

#----------------------------------------------------------------------------------------
	# search for recipes by name 1

	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, findRecipe
	la $a2, search1
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	

#----------------------------------------------------------------------------------------
	# search for recipes by name 2

	lw $t0, addressOfRecipeList


	move $a0, $t0
	la $a1, findRecipe
	la $a2, search2
	jal traverseLinkedList	

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#new lines
	la $a0, lines
	li $v0, 4
	syscall	
	
	

mainTerminate:
	li $v0, 10
	syscall



createArray:
	# Create an array
	# Inputs: $a0 - max number of elements (size), $a1 - size of elements
	# Outputs: $v0 - address of array
	
	
	move $t3, $a0
	mul $t2, $t3, $a1
	addi $t2, $t2, 4
	


	li $v0, 9
	move $a0, $t2
	syscall
	move $t0, $v0


	sw $t3, 0($t0)
	

	move $v0, $t0

	jr $ra

putElementToArray:
	# Store an element (recipe) in an array.
	# Inputs: $a0 - address of array, $a1 - element address, $a2 - index
	

	lw $t0, 0($a0) # we put array size on first element of array
	li $t3, 4

	mul $t2, $a2, $t3


	bge $a2, $t0, indexOutOfBound

	addi $t2, $t2, 4	# jump size info
	add $t2, $t2, $a0
	sw $a1 0($t2)


	jr $ra

indexOutOfBound:
	
	la $a0, indexBoundWarning
	li $v0, 4
	syscall

	la $a0, newLine
	li $v0, 4
	syscall

	jr $ra

createLinkedList:
    # Create a linked list structure.
    # Outputs: $v0 - Address of linked list structure

    
    li $v0, 9           
    li $a0, 8          
    syscall             

    
    move $t0, $v0  

    # head = null
    li $t1, 0        
    sw $t1, 0($t0)    

	# size = 0
	li $t2, 0
	sw $t2, 4($t0)

    
    move $v0, $t0     
    jr $ra             

enqueue:
	# Inputs: $a0 - address of the linked list structure, $a1 - address of data to add

	move $t0, $a0
	move $t6, $a1
	

	li $v0, 9
	li $a0, 8
	syscall
	move $t1, $v0

	sw $t6, 0($t1)
	li $t2, 0
	sw $t2, 4($t1)	#new tail and head

	lw $t3, 0($t0)   #head of current list
	beqz $t3, enqueueEmpty

	
enequeTraverse:
	lw $t5, 4($t3)

	beqz $t5, enequeSetTail
	move $t3, $t5
	j enequeTraverse	

enequeSetTail:
	sw $t1, 4($t3)

	lw  $t6, 4($t0)
	addi $t6, $t6, 1
	sw $t6, 4($t0)

	la $a0, recipeAdded
	li $v0, 4
	syscall

	la $a0, newLine
	li $v0, 4
	syscall

	jr $ra               # Return to caller

enqueueEmpty:
	sw $t1, 0($t0)
	li $t6, 1
	sw $t6, 4($t0)

	la $a0, recipeAdded
	li $v0, 4
	syscall

	la $a0, newLine
	li $v0, 4
	syscall

	move $v0, $t0

	jr $ra


dequeue:
	# Inputs: $a0 - address of the linked list structure
	# Outputs: $v0 - removed head node, 0 if empty
	
	move $t0, $a0	

	lw $t1, 0($t0)
	beqz $t1, dequeEmpty

	lw $t2, 4($t1)
	sw $t2, 0($t0)


	lw $t3, 4($t0)
	addi $t3, $t3, -1
	sw $t3, 4($t0)


	la $a0, recipeRemoved
	li $v0, 4
	syscall

	la $a0, newLine
	li $v0, 4
	syscall

	lw $t4, 0($t1)
	move $v0, $t4
	jr $ra

dequeEmpty:

	li $v0, 0

	jr $ra



queueSize:
	# Inputs: $a0 - address of the linked list structure
	
	lw $v0, 4($a0)

	jr $ra


traverseArray:
	# Traverse and print recipes from array.
	# Inputs: $a0 - address of array, $a1 - called function
	
	addi $sp, $sp, -4        
    sw $ra, 0($sp) 

	move $t0, $a0
	lw $t1, 0($t0)

	addi $t0, $t0, 4

traverseArrayLoop:

	beqz $t1, exitTraverse

	lw $t2, 0($t0)
	
	move $a0, $t2
	jalr $a1	


	addi $t0, $t0, 4
	addi $t1, $t1, -1

	j traverseArrayLoop

exitTraverse:
	lw $ra, 0($sp)    
    addi $sp, $sp, 4  
	jr $ra


traverseLinkedList:
	# Traverse linked list.
	# Inputs: $a0 - head node of linked list, $a1 - called function, $a2 - extra arguments
	

	addi $sp, $sp, -12      
	sw $ra, 0($sp)   
	sw $t9, 4($sp)         
	sw $a1, 8($sp)       

	lw $t9,  0($a0)
	beqz $t9, emptyList       
             

traverseLoop:
	beqz $t9, endTraverse     
	
	lw $a1, 8($sp)
	lw $t1, 0($t9)            
	move $a0, $t1             
	jalr $a1             

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall


	lw $t9, 4($t9)            
	j traverseLoop            

endTraverse:
	lw $ra, 0($sp)           
	lw $t9, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12         
	jr $ra                   

emptyList:
	la $a0, emptyListWarning 
	li $v0, 4
	syscall

	lw $ra, 0($sp)           
	lw $t9, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12        
	jr $ra                   


compareString:
	# Compare two strings.
	# Inputs: $a0 - string 1 address, $a1 - string 2 address
	# Outputs: $v0 - 0 found, 1 not found
	
	move $t0, $a0
	move $t1, $a1

compareLoop:

	lb $t2, 0($t0)
	lb $t3, 0($t1)
	
	bne $t2, $t3, notEqual
	
	beqz $t2, stringsEqual

	addi $t0, $t0, 1
	addi $t1, $t1, 1

	j compareLoop

notEqual:
	li $v0, 1
	jr $ra

stringsEqual:
	li $v0, 0
	jr $ra




createRecipe:
	# Create a recipe and store in the recipe struct.
	# Inputs: $a0 - recipe name, $a1 - address of ingredients array,
	#         $a2 - cooking time, $a3 - difficulty, 0($sp) - rating
	# Outputs: $v0 - recipe address
	
	move $t1, $a0


	li $v0, 9
	li $a0, 20
	syscall
	move $t0, $v0
	
	sw $t1, 0($t0) #save recipe name
	sw $a1, 4($t0) #save address of ing array
	sw $a2, 8($t0) #save cooking time
	sw $a3, 12($t0) #save difficulty
	lw $t1, 0($sp) 
	sw $t1, 16($t0) #save rating


	move $v0, $t0

	jr $ra


findRecipe:
	# Compare two recipe names.
	# Inputs: $a3 - recipe struct address, $a2 - searched recipe name
	

	#this function return 0 if it's found or 1 it's not found


	addi $sp, $sp, -8      
	sw $ra, 0($sp)  
	sw $a0, 4($sp)
	
	lw $t0, 0($a0)


	move $a0, $t0
	move $a1, $a2
	jal compareString

	beqz $v0, recipeFound
	
recipeNotFound:
	la $a0, recipeNotMatch
	li $v0, 4
	syscall

	lw $ra, 0($sp) 
	lw $a0, 4($sp) 
	addi $sp, $sp, 8
	jr $ra

recipeFound:
	la $a0, recipeMatch
	li $v0, 4
	syscall

	
	lw $a0, 4($sp) 
	
	jal printRecipe

	lw $ra, 0($sp) 
	addi $sp, $sp, 8
	
	jr $ra



printRecipe:
	# Print recipe details.
	# Inputs: $a0 - address of recipe struct
	
	addi $sp, $sp, -4        
    sw $ra, 0($sp) 

	move $t7, $a0

	beqz $t7, noRecipe

	#name of recipe
	lw $t0, 0($t7)
	
	la $a0, recipeName
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 4
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#ingredients of recipe
	lw $t1, 4($t7)
	la $a0, ingredients
	li $v0, 4
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#tab
	la $a0, tab
	li $v0, 4
	syscall

	move $a0, $t1
	la $a1, printIngredient
	jal traverseArray


	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#cooking time
	la $a0, cookingTime
	li $v0, 4
	syscall

	lw $a0, 8($t7)
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#difficulty

	la $a0, difficulty
	li $v0, 4
	syscall

	lw $a0, 12($t7)
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#rating

	la $a0, rating
	li $v0, 4
	syscall

	lw $a0, 16($t7)
	li $v0, 1
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	lw $ra, 0($sp)    
    addi $sp, $sp, 4  

	jr $ra

noRecipe:
	la $a0, noRecipeWarning
	li $v0, 4
	syscall

	jr $ra


printIngredient:
	# Print ingredient.
	# Inputs: $a0 - address of ingredient

	move $t3, $a0



	move $a0, $t3
	li $v0, 4
	syscall

	#new lines
	la $a0, newLine
	li $v0, 4
	syscall

	#tab
	la $a0, tab
	li $v0, 4
	syscall

	jr $ra
	