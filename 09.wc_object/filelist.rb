# frozen_string_literal: true

require_relative './file'

class Wc
  class FileList
    attr_reader :files

    def initialize(option)
      files = option.extras
      @files = files.map { |file| Wc::File.new(file) }
    end

    def display(option)
      files.each do |file|
        print file.lines.rjust(8)
        unless option.lists?
          print file.words.rjust(8)
          print file.size.rjust(8)
        end
        puts " #{file.name}"
      end
    end
  end
end
