# frozen_string_literal: true

require './ls'
require './file'
require 'io/console/size'

class Ls
  class FileList
    attr_reader :files

    def initialize(option, pathname)
      pattarn = pathname.join('*')
      files = option.all? ? Dir.glob(pattarn, File::FNM_DOTMATCH) : Dir.glob(pattarn)
      @files = files.sort.map { |file| Ls::File.new(file) }
      @files.reverse! if option.reverse?
    end

    def text(option)
      if option.long?
        format_horizontal(files)
      else
        format_vertical(files)
      end
    end

    private

    def format_horizontal(files)
      link_length = files.max_by(&:nlink).nlink.to_s.length
      size_length = files.max_by(&:size).size.to_s.length
      total_blocks = files.sum(&:blocks)
      puts "total #{total_blocks}"
      files.each do |file|
        puts format_row(file, link_length, size_length)
      end
    end

    def format_row(file, link_length, size_length)
      [
        file.permission.to_s,
        "  #{file.nlink.to_s.rjust(link_length)}",
        " #{file.user}",
        "  #{file.group}",
        "  #{file.size.to_s.rjust(size_length)}",
        " #{file.timestamp}",
        " #{file.name}"
      ].join
    end

    def format_vertical(files)
      name_length = files.max_by { |file| file.name.length }.name.length
      row_size = files.size * (name_length - 2) / (IO.console_size[1] / 2)
      row_size = row_size.zero? ? 1 : row_size
      display_container = Array.new(row_size) { [] }

      files.each_with_index do |file, index|
        display_container[index % row_size].push(file.name)
      end

      display_container.each do |container|
        container.each do |name|
          print name.ljust(name_length + 1)
        end
        print "\n"
      end
    end
  end
end
