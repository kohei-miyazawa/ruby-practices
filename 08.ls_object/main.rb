#!/usr/bin/env ruby
# frozen_string_literal: true

require './option'
require 'pathname'

option = Option.new
path = option.extras[0] || '.'
pathname = Pathname(path)

puts Ls.new(options, pathname).call if __FILE__ == $PROGRAM_NAME
