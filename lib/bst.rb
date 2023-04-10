
#This will take an array and then create a balanced binary search tree.

#The lib file will consist of a Node class and a tree class. 
#The tree class will store an array that contains a root value 
#along with two Node objects for the left and right subtree.

#The Tree class will have the following methods:

#1. build_tree - it takes an array of data, sorts it, and turns it into a binary search tree.
#It will assign a root value which is the midpoint of the sorted array then recursively 
#divide up the array, assigning them into either the left or right subtrees until it is 
#completely constructed. After it has been constructed, the method should then return the
#level 0 root node
	
#2. insert and delete - the method should traverse the tree and add or remove the
#node with the specified value at the appropriate place. The insert and delete methods should
#not be modifying the original input array and re-drawing it.

#3. find - traverses the tree and returns the node that has the specified value
	
#4. level_order - accepts a block, traverses the tree in breadth-first level order, and yield 
#each read node to the block. If no block is given, returns an array of values.
	
#5. inorder (Left, node, right), preorder (node, left, right), and postorder (left, right, node)- 
#each will accept a block, traverse the tree in the corresponding depth first level order, yields  
#the node to thje given block. If no block is given, outputs the value in the corresponding order.
	
#6. height - accepts a node and returns distance from node to leaf node
	
#7. depth - accepts a node and returns distance from node to root node
	
#8. balanced? - determines if difference of height of left and right subtrees are at most 1. If 
#not, it is not balanced.
	
#9. rebalance - produces an array by traversing an unbalanced tree, then outputs it to the build-tree 
#method to make a new balanced binary search tree.

class Tree

    attr_reader :tree

    def initialize(array)
        @array = array
        @tree = build_tree(@array)
    end

    def build_tree(array)
        return nil if array.empty?
        middle = array.length / 2
        node = Node.new(array[middle])
        node.left_tree = build_tree(array[0, middle])
        node.right_tree = build_tree(array[middle + 1, array.length])
        return node
    end

    def preorder(node)
        if node == nil
            return nil
        else
            print node.root
            print self.preorder(node.left_tree)
            print self.preorder(node.right_tree)
        end
    end
    
end

class Node
    attr_accessor  :root, :left_tree, :right_tree

    def initialize(root)
        @root = root
        @left_tree = nil
        @right_tree = nil
    end
end




test_array = [1,2, 3, 4, 5, 6, 7, 8]
test_tree = Tree.new(test_array)
puts test_tree
puts test_tree.class
test_tree.preorder(test_tree.tree)