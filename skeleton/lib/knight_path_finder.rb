require '00_tree_node'

class KnightPathFinder
  DELTAS = [[-2,-1], [-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1][2,1]]

  def initialize(starting pos = [0,0])
    @moves = self.built_move_tree
    @visited_pos = []
    @start_node = PolyTreeNode.new([0,0])
  end

  def find_path(target)
    @target = target
    build_move_tree
  end

  def build_move_tree
    root = @start_node
    # until a node in our tree has a value equal to target, keep building the tree.
    end_node = @start_node.bfs{ |node| node.value == @target}
  end

  def initialize_children(node)
    array = self.valid_moves(node.value)
    @visited_pos.concat array
    array.map { |coordinates| PolyTreeNode.new(coordinates)}
  end

  def self.valid_moves(pos)
    moves = DELTAS.map do |(x,y)|
      [pos[0] + x, pos[1] + y]
    end
    moves.select do |move|
      is_valid?(move)
    end
  end

  def is_valid?(position)
    return false unless position.all? {|pos| pos.between?(0, 7)}
    return false if @visited_pos.include?(position)
    true
  end

  def board_finish
    (0..7).to_a.each do |x|
      (0..7).to_a.each do |y|
        return false if @visited_pos.none?([x,y])
      end
    end
    true
  end

end
night = KnightPathFinder.new([0,0])
night.find_path([0,2])
