# frozen_string_literal: true

require './ls'
require './file'

class Ls
  class FileList
    def initialize(option, pathname)
      pattarn = pathname.join('*')
      files = option.all? ? Dir.glob(pattarn, File::FNM_DOTMATCH) : Dir.glob(pattarn)
      @files = files.sort.map { |file| Ls::File.new(file) }
      @files.reverse! if option.reverse?
    end

    def text(option)
      if option.long?
        'long'
      else
        'not long'
      end
    end
  end
end
