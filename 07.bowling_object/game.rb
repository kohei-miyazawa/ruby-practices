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

  LAST_FRAME_INDEX = 9

  def score
    frames.each_with_index.sum do |frame, index|
      index == LAST_FRAME_INDEX ? frame.score : frame.score + add_bonus(frames, frame, index)
    end
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

  def add_bonus(frames, this_frame, frame_count)
    next_frame = frames[frame_count + 1]
    after_next_frame = frames[frame_count + 2]
    if this_frame.strike?
      if frame_count == 8 || !next_frame.strike?
        [next_frame.first_shot.score, next_frame.second_shot.score].sum
      else
        [next_frame.first_shot.score, after_next_frame.first_shot.score].sum
      end
    elsif this_frame.spare?
      next_frame.first_shot.score
    else
      0
    end
  end
end
