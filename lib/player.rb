class Player
  attr_reader :name, :sign
  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def get_column
    puts 'Choose a column between 1 and 7'
    column = gets.chomp
    valid_column?(column) ? column : get_column
  end

  def valid_column?(column)
    column.between?(1,7) && !column_full?(column)
  end
end