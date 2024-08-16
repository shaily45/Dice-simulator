# frozen_string_literal: true

# Dice class represents a single die with a specified number of sides
class Dice
  attr_reader :sides, :value

  def initialize(sides)
    @sides = Integer(sides).freeze
    roll
  end

  def roll
    frames = ['|', '/', '-', '\\']
    10.times do
      print "\rRolling... #{frames.sample}".yellow
      sleep(0.05)
    end
    print "\r"
    @value = rand(1..@sides)
  end
end
