#!/usr/bin/env ruby
# frozen_string_literal: true

require './game'

puts Game.new(ARGV[0]).score if __FILE__ == $PROGRAM_NAME
