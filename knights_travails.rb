#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry-byebug'

def init_board
  height = 8
  width = 8
  Array.new(height){Array.new(8)}
end

class SquareNode
  attr_reader :location, :children, :parent
  def initialize(parent, location)
    @parent = parent
    @location = location
    @children = []
  end
  def make_children(paths)
    @children = paths.map { |path| SquareNode.new(self, path) }
  end
  def root?
    @parent.nil?
  end
end

class KnightsPath
  def initialize(start)
    @root = SquareNode.new(nil, start)
    @knight = Knight.new
  end

  def gen_path()
    node_queue = [@root]
    exhausted_moves = [@root.location]

    until node_queue.empty?
      parent = node_queue.shift
      legit_moves = @knight.legit_moves(parent.location) - exhausted_moves
      parent.make_children(legit_moves)
      exhausted_moves += legit_moves
      node_queue += parent.children
    end
  end

  # Breadth first search
  def find_node(location)
    node_queue = [@root]
    until node_queue.empty?
      root = node_queue.shift
      return root if root.location == location
      node_queue += root.children
    end
    nil
  end

  def back_track(node)
    back_path = []
    cur_node = node
    until cur_node.nil?
      back_path << cur_node.location
      cur_node = cur_node.parent
    end
    back_path
  end

end
