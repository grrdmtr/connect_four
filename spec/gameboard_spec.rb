require_relative 'lib/game_board'
require_relative 'lib/player'

# I should set up a ConnectFourGame class which should work like this:
# - board setup:
#   6 arrays with length of 7
# - show board  
# - players move:
#   choose a position from 1 to 7
#   make the move on game board
#   show the game board
# - check winner

describe GameBoard do

  describe '#initialize' do

    subject(:board) { described_class.new }

    context 'when initializing a new gameboard' do

      it 'should create an empty array of size 6' do
        expect(board.board.size).to eq(7)
      end
    end
  end

  describe '#drop_piece' do

    subject(:board) { described_class.new }

    context 'when droping a piece on the board' do

      it 'should drop the piece in the correct column' do
        board.drop_piece('X', 1)
        board.drop_piece('O', 2)
        expect(board.board[0]).to eq([nil, nil, nil, nil, nil, "X"])
        expect(board.board[1]).to eq([nil, nil, nil, nil, nil, "O"])
      end

      it 'should drop the piece on the next row if the cell is taken' do
        2.times { board.drop_piece('X', 1) }
        expect(board.board[0]).to eq([nil, nil, nil, nil, 'X', 'X'])
      end
    end
  end

  describe '#four_in_a_column?' do

    context 'when there are the same four sign pieces in a column' do

      subject(:winner_board) { described_class.new }

      before do
        4.times { winner_board.drop_piece('X', 1) }
      end

      it 'should return true' do
        expect(winner_board.four_in_a_column?).to eq(true)
      end
    end

    context 'when there are not the same four sign pieces in a column' do

      subject(:loser_board) { described_class.new }

      before do
        3.times { loser_board.drop_piece('X', 1) }
      end

      it 'should return false' do
        expect(loser_board.four_in_a_column?).to eq(false)
      end
    end
  end

  describe '#four_in_a_row' do

    context 'when there are the same four sign pieces in a row' do

      subject(:winner_board) { described_class.new }

      before do
        0.upto(3) do |i|
          winner_board.drop_piece('X', 1 + i)
        end
      end

      it 'should return true' do
        expect(winner_board.four_in_a_row?).to eq(true)
      end
    end

    context 'when there are not the same four sign pieces in a row' do

      subject(:loser_board) { described_class.new }

      before do
        0.upto(2) do |i|
          loser_board.drop_piece('X', 1 + i)
        end
      end

      it 'should return false' do
        expect(loser_board.four_in_a_row?).to eq(false)
      end
    end
  end

  describe '#four_in_a_diagonal?' do

    context 'when there are the same four sign pieces on a diagonal' do

      subject(:winner_board) { described_class.new }

      before do
        winner_board.drop_piece('X', 1)
        winner_board.drop_piece('O', 2)
        winner_board.drop_piece('X', 2)
        2.times { winner_board.drop_piece('O', 3) }
        winner_board.drop_piece('X', 3)
        3.times { winner_board.drop_piece('O', 4) }
        winner_board.drop_piece('X', 4)
        winner_board.drop_piece('O', 5)
      end

      it 'should return true' do
        expect(winner_board.four_in_a_diagonal?).to eq(true)
      end
    end

    context 'when there are not the same four sign pieces on a diagonal' do

      subject(:loser_board) { described_class.new }

      before do
        0.upto(3) do |i|
          loser_board.drop_piece('X', 1 + i)
        end
      end
      
      it 'should return false' do
        expect(loser_board.four_in_a_diagonal?).to eq(false)
      end
    end
  end

  describe '#check_winner' do
    
    context 'when board has a winning solution' do

      subject(:winner_board) { described_class.new }
      
      before do
        0.upto(3) do |i|
          winner_board.drop_piece('X', 1 + i)
        end
      end
      
      it 'should return true' do
        expect(winner_board.check_winner).to eq(true)
      end
    end
  end

  describe '#draw?' do

    subject(:board) { described_class.new }
    
    context 'when table is not full' do

      it 'should return false when table is not full' do
        expect(board.draw?).to eq(false)
      end
    end

    context 'whem table is full' do

      it 'should return true' do
        board.board.fill(["O", "O", "O", "O", "O", "O"])
        expect(board.draw?).to eq(true)
      end
    end
  end


  describe "#column_full?" do
    
    context "when a column is full" do
    
      subject(:board) { described_class.new }
    
      before do
        6.times { board.drop_piece('X', 1) }
      end
    
      it 'should return true when column is full' do
        expect(board.column_full?).to eq(true)
      end
    end
    
    context "when a column is not full" do
    
      subject(:board) { described_class.new }
    
      before do
        5.times { board.drop_piece('X', 1) }
      end
    
      it 'should return false when column is not full' do
        expect(board.column_full?).to eq(false)
      end
    end
    
    context "when selected column is full" do
    
      subject(:board) { described_class.new }
    
      before do
        6.times { board.drop_piece('X', 1) }
      end
    
      it 'should return true when selected column is full' do
        expect(board.column_full?(1)).to eq(true)
      end
    end
    
    context "when selected column is not full" do
    
      subject(:board) { described_class.new }
    
      before do
        5.times { board.drop_piece('X', 1) }
      end
    
      it 'should return false when selected column is not full' do
        expect(board.column_full?(1)).to eq(false)
      end
    end
  end
end
