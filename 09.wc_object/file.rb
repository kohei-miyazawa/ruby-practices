# frozen_string_literal: true

class Wc
  class File
    attr_reader :name, :lines, :words, :size

    def initialize(file)
      @name = file
      @lines = IO.readlines(file).size.to_s
      @words = IO.read(file).split(' ').size.to_s
      @size = ::File.stat(file).size.to_s
    end
  end
end
