# frozen_string_literal: true

class Ls
  def initialize(option, pathname)
    @option = option
    @pathname = pathname
    @file_list = Ls::FileList.new(option, pathname)
  end

  def call
    @file_list.text(@option)
  end
end

class Ls::FileList
  def initialize(option, pathname)
    pattarn = pathname.join('*')
    files = option.all? ? Dir.glob(pattarn, File::FNM_DOTMATCH) : Dir.glob(pattarn)
    @files = files.sort.map { |file| LS::File.new(file) }
    option.reverse? ? @files.reverse : @files
  end

  def text(option)
    if option.long?
      'long'
    else
      'not long'
    end
  end
end

class Ls::File

end
