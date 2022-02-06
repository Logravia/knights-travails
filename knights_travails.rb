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

