require 'pry'

class Robot
  VALID_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT)
  X_UNITS = 0..4
  Y_UNITS = 0..4

  attr_accessor :instructions, :directions

  def initialize(input_file)
    @directions = %w(NORTH EAST SOUTH WEST)
    @instructions = File.read(input_file).split("\n")
  end

  def play
    @instructions.each do |line|
      next unless Regexp.new("^#{VALID_COMMANDS.join('|')}").match?(line)

      if line[0..4] == 'PLACE'
        place_robot_at(line.split(' ')[1]) if valid_place?(line)
      elsif line == 'MOVE'
        step_ahead
      elsif line == 'LEFT'
        turn_left if @f
      elsif line == 'RIGHT'
        turn_right if @f
      elsif line == 'REPORT' 
        break
      else
        puts "Invalid Input .... #{line}"
      end
    end

    build_report
  end

  private

  def valid_place?(place_instruction)
    return false unless Regexp.new("PLACE\s\\d,\\d,(#{directions.join('|')})").match?(place_instruction)

    x_y_dir = place_instruction.split(' ')[1].split(',')

    valid_x = X_UNITS.include? x_y_dir[0].to_i
    valid_y = Y_UNITS.include? x_y_dir[1].to_i
    valid_direction = directions.include? x_y_dir[2]

    valid_x && valid_y && valid_direction
  end

  def place_robot_at(location)
    place = location.split(',')

    @x = place[0].to_i
    @y = place[1].to_i
    @f = place[2]
    directions.push(directions.shift) until directions.first == @f
  end

  def step_ahead
    case @f
    when 'NORTH'
      @y = [@y+1, X_UNITS.max].min
    when 'EAST'
      @x = [@x+1, X_UNITS.max].min
    when 'SOUTH'
      @y = [@y-1, Y_UNITS.min].max
    when 'WEST'
      @x = [@x-1, X_UNITS.min].max
    end
  end

  def turn_left
    directions.rotate!(-1)
    @f = directions.first
  end

  def turn_right
    directions.rotate!
    @f = directions.first
  end

  def build_report
    if @f
      "#{@x},#{@y},#{@f}"
    else
      'The Toy is not placed on the table.'
    end
  end
end
