
#This will take an array and then create a balanced binary search tree.

#The lib file will consist of a Node class and a tree class. 
#The tree class will store a root node that contains a root value 
#along with two Node objects for the left and right subtree.

class Tree

    attr_reader :tree

    def initialize(array)
        @array = array
        @tree = build_tree(@array)
    end

#builds the actual balanced binary search tree

    def build_tree(array)
        return nil if array.empty?
        middle = array.length / 2
        node = Node.new(array[middle])
        node.left_tree = build_tree(array[0, middle])
        node.right_tree = build_tree(array[middle + 1, array.length])
        return node
    end

#creates a node with the specified value as the root node, then traverses the tree, and adds the node as a leaf node

    def insert(value, node = @tree)
        if node.root > value && node.left_tree != nil
            self.insert(value, node.left_tree)
        elsif node.root > value && node.left_tree == nil
            node.left_tree = Node.new(value)
            return
        end
        if node.root < value && node.right_tree != nil
            self.insert(value, node.right_tree)
        elsif node.root < value && node.right_tree == nil
            node.right_tree = Node.new(value)
            return
        end
    end

#Traverses the tree and searches for the value
#when the value is found, executes an inorder traversal in order to found the inorder successor of the node
#then replaces it, afterwards, sets the deleted flag to true
#If the found node has only one child, moves that child up one level    

    def delete(value, deleted = false, node = @tree)
        if deleted && node != nil
            if node == nil
                return
            elsif node.root > value
                if node.left_tree.root == value
                    node.left_tree = nil
                else
                    self.delete(value, deleted, node.left_tree)
                end
            elsif node.root < value
                if node.right_tree.root == value
                    node.right_tree = nil
                else
                    self.delete(value, deleted, node.right_tree)
                end
            end
        elsif deleted == false 
            if node.root > value
                self.delete(value, deleted, node.left_tree)
            elsif node.root < value
                self.delete(value, deleted, node.right_tree)
            elsif node.root == value
                if node.left_tree == nil && node.right_tree != nil
                    node.root = node.right_tree.root
                    if node.right_tree.left_tree != nil
                        node.left_tree = node.right_tree.left_tree
                    else
                        node.left_tree = nil
                    end
                    if node.right_tree.right_tree != nil
                        node.right_tree = node.right_tree.right_tree
                    else
                        node.right_tree = nil
                    end
                elsif node.left_tree != nil && node.right_tree == nil
                    node.root = node.left_tree.root
                    if node.left_tree.right_tree != nil
                        node.right_tree = node.left_tree.right_tree
                    else
                        node.right_tree = nil
                    end
                    if node.left_tree.left_tree != nil
                        node.left_tree = node.left_tree.left_tree
                    else
                        node.left_tree = nil
                    end
                elsif node.left_tree == nil && node.right_tree == nil
                    return
                elsif node.left_tree != nil && node.right_tree != nil
                    replacement_value = self.inorder(node.right_tree).min
                    self.delete(replacement_value, true)
                    node.root = replacement_value
                end
            end
        end
    end

#displays the tree in pre-order depth first traversal 
    
    def preorder(node = @tree, output = [], &block)
        if node == nil
            return nil
        end
        if block_given?
            if block.call(node.root)
                output.push(node.root)
                self.preorder(node.left_tree, output, &block)
                self.preorder(node.right_tree, output, &block)
            else
                self.preorder(node.left_tree, output, &block)
                self.preorder(node.right_tree, output, &block)
            end
        else
            output.push(node.root)
            self.preorder(node.left_tree, output, &block)
            self.preorder(node.right_tree, output, &block)
        end
        return output
    end

#displays the tree in in-order depth first traversal
    
    def inorder(node = @tree, output = [], &block)
        if node == nil
            return nil
        end
        if block_given?
            if block.call(node.root)
                self.inorder(node.left_tree, output, &block)
                output.push(node.root)
                self.inorder(node.right_tree, output, &block)
            else
                self.inorder(node.left_tree, output, &block)
                self.inorder(node.right_tree, output, &block)
            end
        else
            self.inorder(node.left_tree, output, &block)
            output.push(node.root)
            self.inorder(node.right_tree, output, &block)
        end
        return output
    end
    
#displays the tree in postorder depth-first traversal    
    
    def postorder(node = @tree, output = [], &block)
        if node == nil
            return nil
        end
        if block_given?
            if block.call(node.root)
                self.postorder(node.left_tree, output, &block)
                self.postorder(node.right_tree, output, &block)
                output.push(node.root)
            else
                self.postorder(node.left_tree, output, &block)
                self.postorder(node.right_tree, output, &block)
            end
        else
            self.postorder(node.left_tree, output, &block)
            self.postorder(node.right_tree, output, &block)
            output.push(node.root)
        end
        return output
    end

#traverses the tree and returns the node that has the specified value

    def find(value, node = @tree)
        if node.root == value
            return "Node: #{node}, Left Subtree: #{node.left_tree}, Right Subtree: #{node.right_tree}, Root Node: #{node.root}"
        elsif node.root > value
            self.find(value, node.left_tree)
        elsif node.root < value
            self.find(value, node.right_tree)
        elsif node.left_tree == nil && node.right_tree == nil
            return "Not found"
        end
    end


#4. level_order - accepts a block, traverses the tree in breadth-first level order, and yield 
#each read node to the block. If no block is given, returns an array of values.
#algo: take in a node
#store it in an array
#iterate over this array, storing each node's subtrees in the array
#while also adding the node to another array
#base condition is null and the array is empty

    def level_order(temp_array = [@tree], output_array = [], &block)
        if temp_array.empty?
            return
        end
        working_array = temp_array
        temp_array = []
        working_array.each do |element|
            if element != nil
                if block_given?
                    if block.call(element.root)
                        output_array.push(element.root)
                        temp_array.push(element.left_tree) unless element.left_tree == nil
                        temp_array.push(element.right_tree) unless element.right_tree == nil
                    else
                        temp_array.push(element.left_tree) unless element.left_tree == nil
                        temp_array.push(element.right_tree) unless element.right_tree == nil
                    end
                else
                    output_array.push(element.root)
                    temp_array.push(element.left_tree) unless element.left_tree == nil
                    temp_array.push(element.right_tree) unless element.right_tree == nil
                end
            end
        end
        self.level_order(temp_array, output_array, &block)
        return output_array
    end
    
#height - accepts a node and returns distance from node to leaf node

    def height(node = @tree)
        if node == nil
            return -1
        end

        left_height = self.height(node.left_tree)
        right_height = self.height(node.right_tree)

        if left_height > right_height
            return left_height + 1
        else
            return right_height + 1
        end
    end
	
#depth - accepts a node and returns distance from node to root node

    def depth(node = @tree)
        return self.height(@tree) - self.height(node)
    end
	
#balanced? - determines if difference of height of left and right subtrees are at most 1. If 
#not, it is not balanced.

    def balanced?
        return ((self.height(@tree.left_tree) - self.height(@tree.right_tree)) in (-1..1))
    end
	
#rebalance - produces an array by traversing an unbalanced tree, then outputs it to the build-tree 
#method to make a new balanced binary search tree.

    def rebalance
        tree_to_rebalance = self.inorder
        tree_to_rebalance.sort!
        @tree = build_tree(tree_to_rebalance)
        return @tree
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

#driver program to test methods of the Tree class

def driver_program(array)
    puts "Random array #{array} has been inputted. Now building a binary search tree"
    array.sort!
    test_tree = Tree.new(array)
    puts "Now testing if the search tree is balanced: #{test_tree.balanced?}"
    puts "Printing out the tree in level order: #{test_tree.level_order.join('-')}"
    puts "Printing out the tree in pre-order: #{test_tree.preorder.join('-')}"
    puts "Printing out the tree in in-order: #{test_tree.inorder.join('-')}"
    puts "Printing out the tree in post-order: #{test_tree.postorder.join('-')}"
    puts "Now adding numbers to unbalance the tree..."
    test_tree.insert(12312)
    test_tree.insert(9999)
    test_tree.insert(756)
    test_tree.insert(88132)
    puts "Is the binary tree balanced?: #{test_tree.balanced?}"
    puts "Now rebalancing the tree..."
    test_tree.rebalance
    puts "Is the rebalanced binary tree balanced? #{test_tree.balanced?}"
    puts "Printing out the new tree in level order: #{test_tree.level_order.join('-')}"
    puts "Printing out the new tree in pre-order: #{test_tree.preorder.join('-')}"
    puts "Printing out the new tree in in-order: #{test_tree.inorder.join('-')}"
    puts "Printing out the new tree in post-order: #{test_tree.postorder.join('-')}"
end

test_array = (Array.new(15) {rand(1..100)})
driver_program(test_array)


#test_array = [1, 2, 3, 4, 5]
#test_tree = Tree.new(test_array)
#puts test_tree
#print test_tree.preorder
#test_tree.delete(5)
#print test_tree.preorder
#test_tree.insert(43)
#test_tree.insert(234)
#test_tree.insert(2342)

#puts ''
#print test_tree.preorder
#puts ''
#puts test_tree.balanced?
#puts test_tree.rebalance
#puts test_tree.balanced?
#puts ''
#print test_tree.preorder

#test_block = Proc.new {|value| value > 4}
#puts test_tree.inorder.join(' ')
#test_tree.delete(5)
#print test_tree.inorder
#print test_tree.preorder

#test_tree.insert(9)
#puts ""
#test_tree.preorder