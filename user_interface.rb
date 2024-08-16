# frozen_string_literal: true

require 'colorize'

# UserInterface class handles the user interface and interaction with the user
class UserInterface
  def self.run
    print_welcome_message
    num_dice = get_number_of_dice
    dice_config = get_dice_configuration(num_dice)
    result = dice_roller.roll(dice_config)

    display_results(result)
  end

  def self.print_welcome_message
    system('clear')
    ascii_file_path = File.join(__dir__, 'assets', 'ascii-art.txt')
    File.open(ascii_file_path, 'r') do |file|
      puts file.read
    end
    puts 'Welcome to the Dice Simulator!'.colorize(:cyan)
  end

  def self.dice_roller
    @dice_roller ||= DiceRoller.new
  end

  def self.get_number_of_dice
    loop do
      num_dice = get_and_validate_input('Enter the number of dice to roll: ')
      return num_dice if positive_integer(num_dice, 'Please select atleast 1 dice'.red)
    end
  end

  def self.get_dice_configuration(num_dice)
    (1..num_dice).map do |i|
      get_valid_sides("Enter the number of sides for die #{i}: ")
    end
  end

  def self.get_valid_sides(prompt)
    loop do
      sides = get_and_validate_input(prompt)
      return sides if positive_integer(sides, 'Dice should have at least 1 side'.red)
    end
  end

  def self.display_results(result)
    puts result.description
    puts "Values rolled: #{result.individual_values.join(', ')} ".green
    puts "Total value: #{result.total_value} ".green
  end

  def self.positive_integer(value, error_message)
    if value < 1
      puts error_message
      false
    else
      true
    end
  end

  def self.get_and_validate_input(prompt)
    print prompt
    Integer(gets.chomp)
  rescue ArgumentError
    puts 'Invalid input. Please enter a valid number.'.red
    retry
  end
end
