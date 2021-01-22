# frozen_string_literal: true

require 'optparse'

class Option
  def initialize
    @options = {}
    OptionParser.new do |o|
      o.on('-a', 'do not ignore entries starting with .') { |v| @options[:a] = v }
      o.on('-l', 'use a long listing format') { |v| @options[:l] = v }
      o.on('-r', 'reverse order while sorting') { |v| @options[:r] = v }
      o.parse!(ARGV)
    end
  end

  def extras
    ARGV
  end

  def all?
    get(:a)
  end

  def long?
    get(:l)
  end

  def reverse?
    get(:r)
  end

  private

  def get(name)
    @options[name]
  end
end
