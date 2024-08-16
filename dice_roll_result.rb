# frozen_string_literal: true

# DiceRollResult class represents the result of rolling dice
class DiceRollResult
  attr_reader :description, :individual_values, :total_value

  def initialize(dice)
    @description = "Rolled #{dice.map(&:sides).join(', ')}-sided dice"
    @individual_values = dice.map(&:value)
    @total_value = @individual_values.sum
  end
end
