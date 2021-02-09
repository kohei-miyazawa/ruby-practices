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
        print file.lines.to_s.rjust(8)
        unless option.lists?
          print file.words.to_s.rjust(8)
          print file.size.to_s.rjust(8)
        end
        puts " #{file.name}"
      end
      display_total(option) if option.extras.size >= 2
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
