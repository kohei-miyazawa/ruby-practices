# frozen_string_literal: true

class Wc
  class Data
    attr_reader :lines, :words, :size

    def initialize(stdin)
      rows = stdin.readlines
      @lines = rows.size.to_s
      @words = rows.join.split.size.to_s
      @size = rows.join.size.to_s
    end

    def display(option)
      print lines.rjust(8)
      unless option.lists?
        print words.rjust(8)
        print size.rjust(8)
      end
      print "\n"
    end
  end
end
