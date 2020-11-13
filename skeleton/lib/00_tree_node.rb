require "byebug"
class PolyTreeNode
    attr_reader :value, :children, :parent
    def initialize(value)
        @value = value
        @children =[] 
        @parent = nil
      end

    def parent=(dad)
      if dad == nil
        @parent = dad
      end
      if @parent != nil
        @parent.children.delete(self)
        @parent = dad
        dad.children << self
      end
      if @parent == nil && dad != nil
        @parent = dad
        dad.children << self
      end
    end

    def inspect
      { 'value' => @value, 'parent_value' => @parent }.inspect
    end

    def add_child(child)
      child.parent = self
    end

    def remove_child(child)
      if !@children.include?(child)
        raise "node is not a child"
      else 
        child.parent = nil
      end
    end

    def dfs(target_value)
      node = self
      return node if node.value == target_value
      
      node.children.each do |child|
        left = child.dfs(target_value)
        if left != nil 
          return left
        end
      end

      return nil
    end

    def bfs(target_value)
      queue = [self]
      until queue.empty?
        ele = queue.shift
        return ele if ele.value == target_value
        ele.children.each {|child| queue << child}
      end
      nil
    end
end

# node1 = PolyTreeNode.new("a")
# node2 = PolyTreeNode.new("b")
# node4 = PolyTreeNode.new("c")
# node5 = PolyTreeNode.new("d")
# node6 = PolyTreeNode.new("e")
# node3 = PolyTreeNode.new("f")

# node2.add_child(node4)
# node3.add_child(node5)
# node1.add_child(node2)
# node1.add_child(node3)
# node5.add_child(node6)

# node1.dfs("d")



#n1 has no parent -- root -- n1.parent=(nil) 