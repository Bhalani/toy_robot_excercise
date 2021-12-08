require_relative '../lib/robot'

describe Robot do
  context 'When there are valid instructions' do
    context 'When there are single place command' do
      it 'should follow the instruction' do
        expect(Robot.new('./spec/factory_data/valid_instructions_set_1.txt').play).to eq '1,2,WEST'

        expect(Robot.new('./spec/factory_data/valid_instructions_set_2.txt').play).to eq '2,0,EAST'

        expect(Robot.new('./spec/factory_data/valid_instructions_set_3.txt').play).to eq '0,0,NORTH'
      end
    end

    context 'When there are more than one place command' do
      it 'should return right report based on latest place instruction' do
        expect(Robot.new('./spec/factory_data/multiple_place_instruction.txt').play).to eq '3,1,SOUTH'
      end
    end
  end

  context 'When there are invalid moves in instructions' do
    it 'should not drop the toy out of table' do
      expect(Robot.new('./spec/factory_data/invalid_moves.txt').play).to eq '0,4,NORTH'
    end
  end

  context 'When there are invalid place instruction' do
    it 'should not place the toy' do
      expect(Robot.new('./spec/factory_data/invalid_place_coordinates.txt').play).to eq 'The Toy is not placed on the table.'

      expect(Robot.new('./spec/factory_data/invalid_place_direction.txt').play).to eq 'The Toy is not placed on the table.'
    end
  end

  context 'When there outrange place instruction' do
    it 'should not place the toy on the table' do
      expect(Robot.new('./spec/factory_data/outrange_place_instruction.txt').play).to eq 'The Toy is not placed on the table.'
    end
  end

  context 'When there is no place instruction' do
    it 'should not place the toy on the table' do    
      expect(Robot.new('./spec/factory_data/no_place_instruction.txt').play).to eq 'The Toy is not placed on the table.'
    end
  end

  context 'When there are some invalid instructions' do
    it 'should ignore those instruction follow valid instruction' do
      expect(Robot.new('./spec/factory_data/invalid_commands.txt').play).to eq '2,2,SOUTH'
    end
  end
end
