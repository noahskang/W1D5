require_relative 'kpf'
require_relative 'tree_node'



night = KnightPathFinder.new([0,0])
p night.build_move_tree
p night.start_node.children
