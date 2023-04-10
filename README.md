# Binary_search_tree

This will take an array and then create a balanced binary search tree.

The lib file will consist of a Node class and a tree class. 
The tree class will store an array that contains a root value 
along with two Node objects for the left and right subtree.

The Node class will contain the left and right subtrees.

The Tree class will have the following methods:

	1. build_tree - it takes an array of data, sorts it, and turns it into a binary search tree. It will assign a root value which is the midpoint of the sorted array then recursively divide up the array, assigning them into either the left or right subtrees until it is completely constructed. After it has been constructed, the method should then return the
level 0 root node
	
	2. insert and delete - the method should traverse the tree and add or remove the
node with the specified value at the appropriate place. The insert and delete methods should
not be modifying the original input array and re-drawing it.

	3. find - traverses the tree and returns the node that has the specified value
	
	4. level_order - accepts a block, traverses the tree in breadth-first level order, and yield each read node to the block. If no block is given, returns an array of values.
	
	5. inorder (Left, node, right), preorder (node, left, right), and postorder (left, right, node)- each will accept a block, traverse the tree in the corresponding depth first level order, yields  the node to thje given block. If no block is given, outputs the value in the corresponding order.
	
	6. height - accepts a node and returns distance from node to leaf node
	
	7. depth - accepts a node and returns distance from node to root node
	
	8. balanced? - determines if difference of height of left and right subtrees are at most 1. If not, it is not balanced.
	
	9. rebalance - produces an array by traversing an unbalanced tree, then outputs it to the build-tree method to make a new balanced binary search tree.


Test steps:


    Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
    Confirm that the tree is balanced by calling #balanced?
    Print out all elements in level, pre, post, and in order
    Unbalance the tree by adding several numbers > 100
    Confirm that the tree is unbalanced by calling #balanced?
    Balance the tree by calling #rebalance
    Confirm that the tree is balanced by calling #balanced?
    Print out all elements in level, pre, post, and in order

