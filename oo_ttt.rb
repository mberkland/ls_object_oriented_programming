module Display
  def clear
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts "Hello #{human.name}"
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "#{human.name}, thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "#{human.name} is a #{human.marker}." \
         " #{computer.name} is a #{computer.marker}."
    puts ""
    puts "First to 5 wins the game!"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_winner_count
    puts "Winner count: #{human.name} => #{human.wins}, " \
    "#{computer.name} => #{computer.wins}"
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def joiner(array, separator=", ", final_word="or")
    if array.size > 1
      index = 0
      output = ""

      while index < array.size - 1
        output += array[index].to_s + separator
        index += 1
      end
      "#{output}#{final_word} #{array[-1]}"
    else
      array[0].to_s
    end
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  # takes array of square objects and makes an array of their markers
  def to_marker_arr(array)
    [array[0].marker, array[1].marker, array[2].marker]
  end

  def winning_squares?(marker)
    game_winning_squares(marker).length.positive?
  end

  def two_squares_marked?(line, marker)
    to_marker_arr(@squares.values_at(*line)).count(marker) == 2
  end

  def index_of_space(line)
    to_marker_arr(@squares.values_at(*line)).index(" ")
  end

  def incomplete_line?(line)
    !!index_of_space(line)
  end

  def player_won?(line)
    to_marker_arr(@squares.values_at(*line)).uniq.length == 1
  end

  def find_winning_marker(line)
    @squares[line[0]].marker
  end

  # return winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      unless incomplete_line?(line)
        return find_winning_marker(line) if player_won?(line)
      end
    end
    nil
  end

  def game_winning_squares(marker) # returns an array
    winning_squares = []
    WINNING_LINES.each do |line|
      next unless two_squares_marked?(line, marker) && incomplete_line?(line)
      winning_square = index_of_space(line)
      winning_squares.push(line[winning_square])
    end
    winning_squares
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
end

class Square
  INITIAL_MARKER = " ".freeze

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker, :name, :wins

  def initialize
    @wins = 0
    set_name
    set_marker
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def set_marker
    m = ''
    loop do
      puts "Please choose a marker (X or O):"
      m = gets.chomp.upcase
      break if ['X', 'O'].include?(m)
      puts "Sorry, you must enter an X or an O"
    end
    self.marker = m
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5', 'Ziggy'].sample
  end

  def set_marker
    self.marker = nil
  end
end

class TTTGame
  include Display

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    set_computer_marker
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board
      play_round
      change_winner_count
      display_result
      display_winner_count
      if five_wins?
        break unless play_again?
        score_reset
      else
        next_round
      end
      game_reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def play_round
    loop do
      current_player_moves
      break if someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def set_computer_marker
    @current_marker = human.marker
    human.marker == 'X' ? computer.marker = 'O' : computer.marker = 'X'
  end

  def human_moves
    puts "Choose a square: (#{joiner(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end
    board[square] = human.marker
  end

  def computer_moves
    if board.unmarked_keys.include?(5)
      board[5] = computer.marker
    elsif board.winning_squares?(computer.marker)
      board[board.game_winning_squares(computer.marker)[0]] = computer.marker
    elsif board.winning_squares?(human.marker)
      board[board.game_winning_squares(human.marker)[0]] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def change_winner_count
    case board.winning_marker
    when human.marker
      human.wins += 1
    when computer.marker
      computer.wins += 1
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def five_wins?
    human.wins == 5 || computer.wins == 5
  end

  def game_reset
    board.reset
    @current_marker = human.marker
    clear
  end

  def next_round
    puts 'Press enter for next round:'
    gets.chomp
  end

  def score_reset
    human.wins = 0
    computer.wins = 0
  end

  def someone_won?
    !!board.winning_marker
  end
end

game = TTTGame.new
game.play
