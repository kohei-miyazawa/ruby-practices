#!/usr/bin/env ruby
# frozen_string_literal: true

require './game'
require 'minitest/autorun'

class BowlingTest < Minitest::Test
  def test_calc_1
    assert_equal 139, Game.new('6390038273X9180X645').score
  end

  def test_calc_2
    assert_equal 164, Game.new('6390038273X9180XXXX').score
  end

  def test_calc_3
    assert_equal 107, Game.new('0X150000XXX518104').score
  end

  def test_calc_all_zero
    assert_equal 0, Game.new('00' * 10).score
  end

  def test_calc_perfect
    assert_equal 300, Game.new('X' * 12).score
  end
end
