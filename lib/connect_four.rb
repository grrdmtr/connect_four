require_relative 'game_board.rb'
require_relative 'player.rb'

class ConnectFour
  attr_accessor :board, :player_1, :player_2, :current_player

  def initialize
    @player_1 = Player.new('Mia', 'X')
    @player_2 = Player.new('Igor', 'O')
    @board = GameBoard.new
    @current_player = @player_1
    game_loop
  end

  def game_loop
    puts 'Welcome to Connect Four!'
    loop do
      @board.display_board
      puts "#{@current_player.name} choose a column (1-7) to make your move."
      column = get_column
      @board.drop_piece(@current_player.sign, column)
      check_game_over
      switch_player
    end
  end

  def get_column
    puts 'Choose a column between 1 and 7'
    column = gets.chomp.to_i
    valid_column?(column) ? column : get_column
  end

  def valid_column?(column)
    column.between?(1,7) && !@board.column_full?(column)
  end

  def check_game_over
    if @board.check_winner
      puts "#{@current_player.name} wins"
      reset_game
    elsif @board.draw?
      puts "It's a draw"
      reset_game
    end
  end

  def play_again?
    puts "Would you like to play again? (y/n)"
    input = gets.chomp
    if input == "y"
      return true
    elsif input == "n"
      return false
    else
      puts "Invalid input."
      play_again?
    end
  end

  def reset_game
    if play_again?
      ConnectFour.new
    else
      exit
    end
  end

  def switch_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end
end

game = ConnectFour.new