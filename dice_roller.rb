# frozen_string_literal: true

require_relative 'dice_roll_result'
require_relative 'dice'

# DiceRoller class handles the rolling of dice and returns the result
class DiceRoller
  def roll(dice_config)
    dice = dice_config.map { |sides| Dice.new(sides) }
    DiceRollResult.new(dice)
  end
end
