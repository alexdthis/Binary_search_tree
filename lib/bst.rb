
#This will take an array and then create a balanced binary search tree.

#The lib file will consist of a Node class and a tree class. 
#The tree class will store an array that contains a root value 
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
        if node.left_tree == nil && node.right_tree == nil
            if node.root > value
                node.left_tree = Node.new(value)
                return nil
            else
                node.right_tree = Node.new(value)
                return nil
            end
        end
        if node.root > value
            self.insert(value, node.left_tree)
        else
            self.insert(value, node.right_tree)
        end
    end

#Traverses the tree and searches for the value
#when the value is found, executes an inorder traversal in order to found the inorder successor of the node
#then replaces it, afterwards, sets the deleted flag to true    

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
                    node.root = node.right_tree
                    node.right_tree = nil
                elsif node.left_tree != nil && node.right_tree == nil
                    node.root = node.left_tree
                    node.left_tree = nil
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

#The Tree class will have the following methods:

#4. level_order - accepts a block, traverses the tree in breadth-first level order, and yield 
#each read node to the block. If no block is given, returns an array of values.
	
#6. height - accepts a node and returns distance from node to leaf node
	
#7. depth - accepts a node and returns distance from node to root node
	
#8. balanced? - determines if difference of height of left and right subtrees are at most 1. If 
#not, it is not balanced.
	
#9. rebalance - produces an array by traversing an unbalanced tree, then outputs it to the build-tree 
#method to make a new balanced binary search tree.

end

class Node
    attr_accessor  :root, :left_tree, :right_tree

    def initialize(root)
        @root = root
        @left_tree = nil
        @right_tree = nil
    end
end




test_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
test_tree = Tree.new(test_array)
puts test_tree
puts test_tree.find(7)
#test_block = Proc.new {|value| value > 4}
#puts test_tree.inorder.join(' ')
#test_tree.delete(5)
#print test_tree.inorder
#print test_tree.preorder

#test_tree.insert(9)
#puts ""
#test_tree.preorder