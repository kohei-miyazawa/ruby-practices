# frozen_string_literal: true

require_relative './file'
require 'pathname'

class Wc
  class FileList
    attr_reader :arguments, :files

    def initialize(option)
      @arguments = option.extras.map { |argument| Pathname(argument) }
      @files = @arguments.map { |argument| Wc::File.new(argument) if argument.file? }.compact
    end

    def display(option)
      arguments.each do |argument|
        if argument.directory?
          puts "wc: #{argument}: read: Is a directory"
        elsif !argument.exist?
          puts "wc: #{argument}: open: No such file or directory"
        else
          display_file(argument, option)
        end
      end
      display_total(option) if arguments.size >= 2
    end

    private

    def display_file(argument, option)
      file = files.find { |f| f.name == argument }
      print file.lines.to_s.rjust(8)
      unless option.lists?
        print file.words.to_s.rjust(8)
        print file.size.to_s.rjust(8)
      end
      puts " #{file.name}"
    end

    def display_total(option)
      print files.sum(&:lines).to_s.rjust(8)
      unless option.lists?
        print files.sum(&:words).to_s.rjust(8)
        print files.sum(&:size).to_s.rjust(8)
      end
      puts ' total'
    end
  end
end
