#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './option'
require_relative './wc'

option = Option.new

Wc.new($stdin, option).call if __FILE__ == $PROGRAM_NAME
