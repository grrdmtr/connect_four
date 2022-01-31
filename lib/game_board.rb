class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(7) { Array.new(6) }
  end
  
  def display_board
    0.upto(5) do |i|
      print "|"
      0.upto(6) do |n|
        print @board[n][i].nil? ? "   |" : " #{@board[n][i]} |"
      end
      puts
    end
  end

  def drop_piece(sign, column)
    5.downto(0) do |i|
      if @board[column - 1][i].nil?
        @board[column - 1][i] = sign
        break
      end
    end
  end

  def check_winner
    if four_in_a_row? || four_in_a_column? || four_in_a_diagonal?
      return true
    else
      false
    end
  end

  def draw?
    draw = false
    @board.each do |column|
      draw = true if column.none? {|cell| cell.nil?}
    end
    draw
  end

  def game_finish
    true
  end

  def four_in_a_row?
    0.upto(3) do |n|
      0.upto(5) do |i|
        if @board[n][i] == @board[n + 1][i] && @board[n][i] == @board[n + 2][i] && @board[n][i] == @board[n + 3][i]
          return true unless @board[n][i].nil?
        end
      end
    end
    false
  end

  def four_in_a_column?
    0.upto(6) do |n|
      0.upto(2) do |i|
        if @board[n][i] == @board[n][i + 1] && @board[n][i] == @board[n][i + 2] && @board[n][i] == @board[n][i + 3]
          return true unless @board[n][i].nil?
        end
      end
    end
    false
  end

  def four_in_a_diagonal?
    0.upto(2) do |n|
      0.upto(3) do |i|
        if @board[n][i] == @board[n+1][i+1] && @board[n][i] == @board[n+2][i+2] && @board[n][i] == @board[n+3][i+3]
          return true unless @board[n][i].nil?
        end
      end
    end
    6.downto(3) do |n|
      0.upto(3) do |i|
        if @board[n][i] == @board[n-1][i+1] && @board[n][i] == @board[n-2][i+2] && @board[n][i] == @board[n-3][i+3]
          return true unless @board[n][i].nil?
        end
      end
    end
    false
  end

  def column_full?(column = nil)
    if column.nil?
      @board.each do |column| 
        if column.include?(nil)
          return false
        else
          return true
        end
      end
    elsif @board[column - 1].include?(nil)
      return false
    else
      return true
    end
  end
end

# winner_board = GameBoard.new
# winner_board.drop_piece('X', 1)
# winner_board.drop_piece('O', 2)
# winner_board.drop_piece('X', 2)
# 2.times { winner_board.drop_piece('O', 3) }
# winner_board.drop_piece('X', 3)
# 3.times { winner_board.drop_piece('O', 4) }
# winner_board.drop_piece('X', 4)
# winner_board.drop_piece('O', 5)
# winner_board.display_board