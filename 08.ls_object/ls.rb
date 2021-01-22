# frozen_string_literal: true

require 'etc'

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

class Ls::File
  attr_reader :path, :type, :permission, :blocks, :nlink, :user, :group, :size, :timestamp, :name

  TYPE = { file: '-', directory: 'd' }.freeze
  MODE = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }.freeze

  def initialize(path)
    @path = path
    type = File.ftype(path)
    @type = TYPE[type.to_sym]
    stat = File.stat(path)
    @permission = "#{@type}#{to_permission_text(stat)}"
    @blocks = stat.blocks
    @nlink = stat.nlink
    @user = Etc.getpwuid(stat.uid).name
    @group = Etc.getgrgid(stat.gid).name
    @size = stat.size
    @timestamp = stat.atime.strftime('%_m %_d %R')
    @name = File.basename(path)
  end

  private

  def to_permission_text(stat)
    stat
      .mode
      .to_s(8)[-3..-1]
      .chars
      .map { |c| MODE[c.to_i] }
      .join
  end
end
