#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './option'
require_relative './item'
require 'pathname'
require 'io/console/size'

def create_item_list(pathname, option)
  return unless Dir.exist?(pathname)

  pattarn = pathname.join('*')
  files = option.all? ? Dir.glob(pattarn, File::FNM_DOTMATCH) : Dir.glob(pattarn)
  items = files.sort.map { |file| Item.new(file) }
  option.reverse? ? items.reverse : items
end

def format_horizontal(items)
  links_length = items.max_by(&:nlink).nlink.to_s.length
  size_length = items.max_by(&:size).size.to_s.length
  total_blocks = items.sum(&:blocks)
  puts "total #{total_blocks}"
  items.each do |item|
    adjust_nlink = item.nlink.to_s.rjust(links_length)
    adjust_size = item.size.to_s.rjust(size_length)
    row = "#{item.permission}  #{adjust_nlink} #{item.user}  #{item.group}  #{adjust_size} #{item.timestamp} #{item.name}"
    row += " -> #{File.readlink(item.path)}" if item.type == 'l'
    puts row
  end
end

def format_vertical(items)
  name_length = items.max_by { |item| item.name.length }.name.length
  row_size = items.size * (name_length - 2) / (IO.console_size[1] / 2)
  row_size = row_size.zero? ? 1 : row_size
  display_container = Array.new(row_size) { [] }

  items.each_with_index do |item, index|
    display_container[index % row_size].push(item.name)
  end

  display_container.each do |container|
    container.each do |name|
      print name.ljust(name_length + 1)
    end
    print "\n"
  end
end

option = Option.new
path = option.extras[0] || '.'
pathname = Pathname(path)

items = create_item_list(pathname, option)

if items
  if option.long?
    format_horizontal(items)
  else
    format_vertical(items)
  end
else
  puts "ls: #{pathname}: No such file or directory"
end
