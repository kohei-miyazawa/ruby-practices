#!/usr/bin/env ruby
# frozen_string_literal: true

require './option'
require './ls'
require 'pathname'

option = Option.new
path = option.extras[0] || '.'
pathname = Pathname(path)

Ls.new(option, pathname).call if __FILE__ == $PROGRAM_NAME
