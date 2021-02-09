# frozen_string_literal: true

class Wc
  class File
    attr_reader :name, :lines, :words, :size

    def initialize(file)
      @name = file
      @lines = IO.readlines(file).size
      @words = IO.read(file).split(' ').size
      @size = ::File.stat(file).size
    end
  end
end
