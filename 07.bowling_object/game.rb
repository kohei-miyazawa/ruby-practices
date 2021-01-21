# frozen_string_literal: true

require './frame'

class Game
  attr_reader :frames

  def initialize(pinfall_text)
    @frames = []
    frames = build_frames(pinfall_text.chars)
    frames.each do |frame|
      @frames << Frame.new(frame[0], frame[1], frame[2])
    end
  end

  def score
  end

  private

  def build_frames(pinfalls)
    frames = []
    frame = []

    pinfalls.each do |pinfall|
      frame << pinfall

      if frames.size < 10
        if frame.size >= 2 || pinfall == 'X'
          frames << frame.dup
          frame.clear
        end
      else
        frames.last << pinfall
      end
    end

    frames
  end
end
