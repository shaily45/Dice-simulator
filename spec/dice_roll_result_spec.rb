# frozen_string_literal: true

require_relative '../dice_roll_result'
require_relative '../dice'

RSpec.describe DiceRollResult do
  let(:dice1) { instance_double(Dice, sides: 6, value: 4) }
  let(:dice2) { instance_double(Dice, sides: 8, value: 7) }
  let(:dice) { [dice1, dice2] }
  let(:result) { DiceRollResult.new(dice) }

  describe '#initialize' do
    it 'sets the correct description' do
      expect(result.description).to eq('Rolled 6, 8-sided dice')
    end

    it 'sets the individual values' do
      expect(result.individual_values).to eq([4, 7])
    end

    it 'calculates the total value' do
      expect(result.total_value).to eq(11)
    end
  end

  describe '#description' do
    it 'returns a string describing the dice rolled' do
      expect(result.description).to be_a(String)
      expect(result.description).to include('6', '8')
    end
  end

  describe '#individual_values' do
    it 'returns an array of individual dice values' do
      expect(result.individual_values).to be_an(Array)
      expect(result.individual_values).to eq([4, 7])
    end
  end

  describe '#total_value' do
    it 'returns the sum of all dice values' do
      expect(result.total_value).to eq(11)
    end
  end

  context 'with different dice configurations' do
    let(:dice3) { instance_double(Dice, sides: 20, value: 15) }
    let(:dice) { [dice1, dice2, dice3] }

    it 'handles multiple dice correctly' do
      result = DiceRollResult.new(dice)
      expect(result.description).to eq('Rolled 6, 8, 20-sided dice')
      expect(result.individual_values).to eq([4, 7, 15])
      expect(result.total_value).to eq(26)
    end
  end
end
