require 'thread'

class Node
  attr_accessor :pos, :parent, :children
  def initialize(pos, parent = nil)
    @parent = parent
    @pos = pos
    @children = []
  end

  def add_child(node)
    @children.push(node)
  end
end

def possible_moves(pos)
  posx = pos[0]
  posy = pos[1]
  new_positions = []
  new_positions.push([posx + 2, posy + 1]) if posx + 2 < 8 && posy + 1 < 8
  new_positions.push([posx + 2, posy - 1]) if posx + 2 < 8 && posy - 1 > -1
  new_positions.push([posx - 2, posy + 1]) if posx - 2 > -1 && posy + 1 < 8
  new_positions.push([posx - 2, posy - 1]) if posx - 2 > -1 && posy - 1 > -1
  new_positions.push([posx + 1, posy + 2]) if posx + 1 < 8 && posy + 2 < 8
  new_positions.push([posx + 1, posy - 2]) if posx + 1 < 8 && posy - 2 > -1
  new_positions.push([posx - 1, posy + 2]) if posx - 1 > -1 && posy + 2 < 8
  new_positions.push([posx - 1, posy - 2]) if posx - 1 > -1 && posy - 2 > -1
  new_positions
end

def iterator(node, final, queue)
#  p node.parent == nil ? "#{node.pos}" : "#{node.pos}  #{node.parent.pos}"
  return node if node.pos == final
  possible_moves(node.pos).each do |new_position|
    new_node = Node.new(new_position, node)
    node.add_child(new_node)
    queue.push(new_node)
  end
  iterator(queue.pop, final, queue)
end

def display(answer)
  array = []
  until answer.parent == nil
    array.push(answer.pos)
    answer = answer.parent
  end
  array.push(answer.pos)
  until array.empty?
    p array.pop
  end
end

def knight_moves(init, final)
  root = Node.new(init)
  queue = Queue.new
  display(iterator(root, final, queue))
end

knight_moves([3,3],[4,3]
