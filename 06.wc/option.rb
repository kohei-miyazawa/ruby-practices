# frozen_string_literal: true

require 'optparse'

class Option
  def initialize
    @options = {}
    OptionParser.new do |o|
      o.on('-l', 'use a long listing format') { |v| @options[:l] = v }
      o.parse!(ARGV)
    end
  end

  def extras
    ARGV
  end

  def lists?
    get(:l)
  end

  private

  def get(name)
    @options[name]
  end
end
