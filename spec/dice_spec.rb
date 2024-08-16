# frozen_string_literal: true

require_relative '../dice'

RSpec.describe Dice do
  describe '#initialize' do
    it 'creates a dice with the specified number of sides' do
      dice = Dice.new(6)
      expect(dice.sides).to eq(6)
    end

    it 'freezes the number of sides' do
      dice = Dice.new(6)
      expect(dice.sides).to be_frozen
    end

    it 'rolls the dice upon creation' do
      expect_any_instance_of(Dice).to receive(:roll)
      Dice.new(6)
    end

    it 'raises an error for non-integer input' do
      expect { Dice.new('six') }.to raise_error(ArgumentError)
    end
  end

  describe '#roll' do
    let(:dice) { Dice.new(6) }

    it 'sets a new value for the dice' do
      allow(dice).to receive(:rand).and_return(4)
      expect { dice.roll }.to change { dice.value }.to(4)
    end

    it 'returns a value between 1 and the number of sides' do
      5.times do
        dice.roll
        expect(dice.value).to be_between(1, 6)
      end
    end

    it 'displays rolling animation' do
      expect { dice.roll }.to output(/Rolling\.\.\./).to_stdout
    end
  end

  describe '#value' do
    it 'returns the current value of the dice' do
      dice = Dice.new(6)
      allow(dice).to receive(:rand).and_return(3)
      dice.roll
      expect(dice.value).to eq(3)
    end
  end
end
