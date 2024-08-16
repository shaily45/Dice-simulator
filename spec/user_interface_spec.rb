# frozen_string_literal: true

require_relative '../user_interface'
require_relative '../dice_roller'
require_relative '../dice_roll_result'

RSpec.describe UserInterface do
  describe '.run' do
    it 'executes the main program flow' do
      allow(UserInterface).to receive(:print_welcome_message)
      allow(UserInterface).to receive(:get_number_of_dice).and_return(2)
      allow(UserInterface).to receive(:get_dice_configuration).and_return([6, 6])
      allow(UserInterface).to receive(:display_results)

      expect(UserInterface.dice_roller).to receive(:roll).with([6,
                                                                6]).and_return(DiceRollResult.new([Dice.new(6),
                                                                                                   Dice.new(6)]))

      UserInterface.run
    end
  end

  describe '.get_number_of_dice' do
    it 'returns a valid number of dice' do
      allow(UserInterface).to receive(:get_and_validate_input).and_return(3)
      expect(UserInterface.get_number_of_dice).to eq(3)
    end

    it 'retries on invalid input' do
      allow(UserInterface).to receive(:get_and_validate_input).and_return(0, 2)
      expect(UserInterface.get_number_of_dice).to eq(2)
    end
  end

  describe '.get_dice_configuration' do
    it 'returns an array of valid dice sides' do
      allow(UserInterface).to receive(:get_valid_sides).and_return(6, 8)
      expect(UserInterface.get_dice_configuration(2)).to eq([6, 8])
    end
  end

  describe '.get_valid_sides' do
    it 'returns a valid number of sides' do
      allow(UserInterface).to receive(:get_and_validate_input).and_return(6)
      expect(UserInterface.get_valid_sides('Enter sides:')).to eq(6)
    end

    it 'retries on invalid input' do
      allow(UserInterface).to receive(:get_and_validate_input).and_return(0, 6)
      expect(UserInterface.get_valid_sides('Enter sides:')).to eq(6)
    end
  end

  describe '.positive_integer' do
    it 'returns true for positive integers' do
      expect(UserInterface.positive_integer(5, 'Error')).to be true
    end

    it 'returns false for non-positive integers' do
      expect(UserInterface.positive_integer(0, 'Error')).to be false
    end
  end

  describe '.get_and_validate_input' do
    it 'returns valid integer input' do
      allow(UserInterface).to receive(:gets).and_return("5\n")
      expect(UserInterface.get_and_validate_input('Enter number:')).to eq(5)
    end

    it 'retries on non-integer input' do
      allow(UserInterface).to receive(:gets).and_return("abc\n", "5\n")
      expect(UserInterface.get_and_validate_input('Enter number:')).to eq(5)
    end
  end
end
