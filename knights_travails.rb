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

