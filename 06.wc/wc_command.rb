#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './option'
require 'pathname'

option = Option.new

def output_for_arguments(option)
  arguments = option.extras.map { |argument| Pathname(argument) }
  output_list = Hash.new { |hash, key| hash[key] = {} }

  arguments.each do |argument|
    if argument.directory?
      puts "wc: #{argument}: read: Is a directory"
    elsif argument.exist?
      output_list = create_list(output_list, argument)
      output(output_list, argument, option)
    else
      puts "wc: #{argument}: open: No such file or directory"
    end
  end
  output_total(output_list, option) if arguments.size >= 2
end

def create_list(output_list, file)
  output_list[:"#{file}"][:lines] = IO.readlines(file).size
  output_list[:"#{file}"][:words] = IO.read(file).split(' ').size
  output_list[:"#{file}"][:size] = File.stat(file).size
  output_list
end

def output(output_list, file, option)
  print output_list[:"#{file}"][:lines].to_s.rjust(8)
  unless option.lists?
    print output_list[:"#{file}"][:words].to_s.rjust(8)
    print output_list[:"#{file}"][:size].to_s.rjust(8)
  end
  print " #{file}\n"
end

def output_total(output_list, option)
  total = Hash.new(0)
  output_list.each_value do |value|
    total[:lines] += value[:lines]
    unless option.lists?
      total[:words] += value[:words]
      total[:size] += value[:size]
    end
  end
  total.each_value do |value|
    print value.to_s.rjust(8)
  end
  print " total\n"
end

def output_for_standard_input(option)
  f = $stdin.readlines
  print f.size.to_s.rjust(8)
  unless option.lists?
    print f.join.split.size.to_s.rjust(8)
    print f.join.size.to_s.rjust(8)
  end
  print "\n"
end

if $stdin.tty?
  output_for_arguments(option)
else
  output_for_standard_input(option)
end
