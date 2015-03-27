module BinaryTree
  class Node
    attr_reader :value
    attr_accessor :left_child, :right_child

    def initialize(value)
      @value = value
    end

    def value_exist?(root, value)
      if root.value == value
        return true
      elsif root.value > value
        return value_exist?(root.left_child, value)
      else
        return value_exist?(root.right_child, value)
      end
    end

    # depth first searches

    def pre_order_traversal(root, array=[])
      array << root.value
      if root.left_child
        pre_order_traversal(root.left_child, array)
      end
      if root.right_child
        pre_order_traversal(root.right_child, array)
      end
      return array
    end

    def in_order_traversal(root, array=[])
      if root.left_child
        in_order_traversal(root.left_child, array)
      end
      array << root.value
      if root.right_child
        in_order_traversal(root.right_child, array)
      end
      return array
    end

    def post_order_traversal(root, array=[])
      if root.left_child
        post_order_traversal(root.left_child, array)
      end
      if root.right_child
        post_order_traversal(root.right_child, array)
      end
      array << root.value
      return array
    end

# check if in order traversal return sorted array
    def valid_bst?(root)
      if in_order_traversal(root).sort == in_order_traversal(root)
        return true
      else
        return false
      end
    end

# breath first searches
    def children
      [self.left_child, self.right_child]
    end

    def breath_first_search(root)
      queue = []
      visited = []
      queue << root
      visited << root.value

      while queue.any?
        current_node = queue.shift
        current_node.children.each do |child|
          next if visited.include?(child.value)
          queue << child
          visited << child.value if child
          child = current_node
        end
      end
      return visited
    end

    def valid_bst?(root, min=0, max=0)
      until root.left_child.nil? && root.right_child.nil?
        if root.left_child.value < root.value && root.right_child.value > root.value
          min = root.left_child.value
          max = root.right_child.value
          root.children.each {|child| valid_bst?(child, min, max)}
          return true
        end
        return false
      end
    end

  end
end

root = BinaryTree::Node.new(10)
root.left_child = BinaryTree::Node.new(5)
root.right_child = BinaryTree::Node.new(15)
root.left_child.left_child = BinaryTree::Node.new(1)
root.left_child.right_child = BinaryTree::Node.new(7)
root.right_child.left_child = BinaryTree::Node.new(13)
root.right_child.right_child = BinaryTree::Node.new(16)