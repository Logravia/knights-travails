#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry-byebug'

def init_board
  height = 8
  width = 8
  Array.new(height){Array.new(8)}
end

