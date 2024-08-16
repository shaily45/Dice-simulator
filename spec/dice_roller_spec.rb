# frozen_string_literal: true

require_relative '../dice_roller'
require_relative '../dice'
require_relative '../dice_roll_result'

RSpec.describe DiceRoller do
  let(:roller) { DiceRoller.new }

  describe '#roll' do
    it 'creates dice with the specified configurations' do
      dice_config = [6, 8, 20]
      allow(DiceRollResult).to receive(:new).with([nil, nil, nil])
      expect(Dice).to receive(:new).with(6).ordered
      expect(Dice).to receive(:new).with(8).ordered
      expect(Dice).to receive(:new).with(20).ordered
      roller.roll(dice_config)
    end

    it 'returns a DiceRollResult object' do
      result = roller.roll([6])
      expect(result).to be_a(DiceRollResult)
    end

    it 'passes created dice to DiceRollResult' do
      dice_config = [6, 8]
      dice1 = instance_double(Dice)
      dice2 = instance_double(Dice)
      allow(Dice).to receive(:new).and_return(dice1, dice2)

      expect(DiceRollResult).to receive(:new).with([dice1, dice2])
      roller.roll(dice_config)
    end

    it 'handles multiple dice configurations' do
      result = roller.roll([6, 8, 20])
      expect(result.individual_values.size).to eq(3)
    end

    it 'handles a single die configuration' do
      result = roller.roll([10])
      expect(result.individual_values.size).to eq(1)
    end
  end
end
