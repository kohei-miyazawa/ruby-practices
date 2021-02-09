# frozen_string_literal: true

require_relative './filelist'
require_relative './data'

class Wc
  attr_reader :option

  def initialize(stdin, option)
    @option = option
    @lists = stdin.tty? ? Wc::FileList.new(option) : Wc::Data.new(stdin)
  end

  def call
    @lists.display(option)
  end
end
