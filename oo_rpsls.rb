# Object Oriented Rock, Paper, Scissors, Lizard, Spock

class History
  attr_accessor :wins, :losses

  def initialize
    @wins = []
    @losses = []
  end

  def add_win(move)
    self.wins.push(move)
  end

  def add_loss(move)
    self.losses.push(move)
  end

  def restart_history
    self.wins = []
    self.losses = []
  end
end

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']


  WINNERS = { "rock" => %w(scissors lizard), "paper" => %w(rock spock),
              "scissors" => %w(paper lizard), "lizard" => %w(spock paper),
              "spock" => %w(scissors rock) }.freeze

  def initialize(value)
    @value = value
  end


  def winning_choice?(other_choice)
    WINNERS[@value].include?(other_choice)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :name, :move, :history

  def initialize
    @history = History.new
    set_name
  end
end

class Human < Player
  def set_name
    n = " "
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value"
      end
      self.name = n
  end

  def choose
    choice = nil
      loop do
        puts "Please choose rock, paper, scissors, lizard or spock:"
        choice = gets.chomp
        break if Move::VALUES.include?(choice)
        puts "Sorry, invalid chocie"
      end
      self.move = Move.new(choice)
  end
end

class Computer < Player

  def set_name
    self.name = ['R2D2', 'Ziggy', 'Hal', 'Sonny', 'Walee'].sample
  end

  def r2d2
    self.move = Move.new(['rock', 'paper', 'scissors'].sample)
  end

  def ziggy
    choices = ['rock', 'paper', 'scissors', 'lizard', 'spock']
    percent_arr = []
    choices.each do |choice|
      percent = history.losses.count(choice) / history.losses.size.to_f
      percent_arr.push(percent)
    end
   # Fix this!!!
    self.move = Move.new(new_choices.sample)
  end

  def hal
    self.move = Move.new(['lizard', 'spock'].sample)
  end

  def sonny
     self.move = Move.new(['scissors', 'spock'].sample)
  end

  def walee
    self.move = Move.new(Move::VALUES.sample)
  end

  def choose
    case name
    when 'R2D2'
      r2d2
    when 'Ziggy'
      ziggy
    when 'Hal'
      hal
    when 'Sonny'
      sonny
    when 'Walee'
      walee
    end
  end
end

class RPSGame
  attr_accessor :human, :computer, :big_winner

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def ten_wins?(player)
    if player.history.wins.count == 10
      self.big_winner = player.name
      return true
    end
    return false
  end

  def display_welcome_message
    puts "Welcome #{human.name}, to Rock, Paper, Scissors, Lizard, Spock!"
    puts "Win 10 rounds to prove you're the best."
  end

  def display_goodbye_message
    puts "#{human.name}, thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    if human.move.winning_choice?(computer.move.value)
      puts "#{human.name} won!"
      human.history.add_win(human.move.value)
      computer.history.add_loss(computer.move.value)
    elsif computer.move.winning_choice?(human.move.value)
      puts "#{computer.name} won!"
      computer.history.add_win(computer.move.value)
      human.history.add_loss(human.move.value)
    else
      puts "It's a tie!"
    end
  end

  def display_game_count
      puts "#{human.name}: #{human.history.wins.count} wins "
      puts "#{computer.name}: #{computer.history.wins.count} wins"
  end

  def display_big_winner
    puts "#{big_winner} won the whole enchilada!!!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n"
    end
    if answer == 'y'
      human.history.restart_history
      computer.history.restart_history
      return true
    end
    return false
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_winner
      display_game_count
      if ten_wins?(human) || ten_wins?(computer)
        display_big_winner
        break unless play_again?
      end
    end
    display_goodbye_message
  end
end

RPSGame.new.play