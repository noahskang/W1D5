require 'byebug'

class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(node)
    # debugger
    if @parent != nil
      @parent.children.delete(self)
      @parent = node
    else
      @parent = node
    end
    return @parent if @parent == nil
    @parent.children << self unless @parent.children.include?(self)
    @parent
  end

  def add_child(child)
    child.parent= self
  end

  def remove_child(child)
    raise "exception" unless @children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    # ex. of a case when we are passed a Proc:
    # return self if Proc.call(self) == true 
    self.children.each do |child|
      search_result = child.dfs(target_value)
      return search_result if search_result
    end
    nil
  end

  def bfs(target_value)
    return self if target_value == self
    queue = [self]
    until queue.empty?
      current_node = queue.shift
       if current_node.value == target_value
         return current_node
       else
         queue.concat current_node.children
       end
    end

    nil
  end
end
