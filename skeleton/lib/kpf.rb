require_relative 'tree_node'
require 'byebug'

class KnightPathFinder
  DELTAS = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]


  @@visited_pos = []

  def initialize(starting_pos = [0,0])
    # debugger
    @@visited_pos = []
    @start_node = PolyTreeNode.new(starting_pos)
  end

  def find_path(target)
    @target = target

  end

  def build_move_tree
    queue = [@start_node]
    until queue.empty?
      node = queue.shift
      return if board_finish?
       valid_children = initialize_children(node)
       debugger
       queue.concat valid_children
    end
    return @start_node.value
  end

  def initialize_children(node)
    array = KnightPathFinder.valid_moves(node.value)
    @@visited_pos.concat array
    array.map { |coordinates| node.add_child(PolyTreeNode.new(coordinates))}
  end

  def self.valid_moves(pos)
    moves = DELTAS.map {|(x,y)|[pos[0] + x, pos[1] + y]}

    moves.select{|move| KnightPathFinder.is_valid?(move)}
  end

  def self.is_valid?(position)
    return false unless position.all? {|pos| pos.between?(0, 7)}
    # debugger
    return false if @@visited_pos.include?(position)
    true
  end

  def board_finish?
    (0..7).to_a.each do |x|
      (0..7).to_a.each do |y|
        return false if @@visited_pos.none?{|ele| ele==[x,y]}
      end
    end
    true
  end

end

night = KnightPathFinder.new([0,0])
p night.build_move_tree
