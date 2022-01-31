require_relative 'lib/connect_four'

# I should set up a ConnectFourGame class which should work like this:
# - board setup:
#   6 arrays with length of 7
# - show board  
# - players move:
#   choose a position from 1 to 7
#   make the move on game board
#   show the game board
# - check winner

describe ConnectFour do
  subject(:new_game) { described_class.new('Dima', 'Paula') }

  describe '#initialize' do
  
    it 'creates a new boardgame' do
      board =  Array.new(7) { Array.new(6) }
      expect(new_game.board).to eq(board)
    end
  end
end