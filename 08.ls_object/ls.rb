# frozen_string_literal: true

require './filelist'

class Ls
  attr_reader :option

  def initialize(option, pathname)
    @option = option
    @pathname = pathname
    @file_list = Ls::FileList.new(option, pathname)
  end

  def call
    @file_list.text(option)
  end
end
