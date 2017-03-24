class Card
  attr_accessor :suit, :face, :value

  SUIT = ["Hearts", "Clubs", "Diamonds", "Spades"].freeze
  STRAIGHT = [["Ace", 1], ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6],
              ["7", 7], ["8", 8], ["9", 9], ["10", 10], ["Jack", 10],
              ["Queen", 10], ["King", 10]].freeze

  def initialize(suit, face, value)
    @suit = suit
    @face = face
    @value = value
  end

  def to_s
    "==>The #{face} of #{suit}."
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    make_deck
  end

  def make_deck
    Card::SUIT.each do |suit|
      Card::STRAIGHT.each do |face, value|
        cards << Card.new(suit, face, value)
      end
    end
  end

  def deal_card
    card = cards.sample
    cards.delete(card)
    card
  end
end

module CardCount
  def find_base_count
    total = 0
    cards.each { |card| total += card.value }
    total
  end

  def ace?
    cards.each do |card|
      if card.face.include?("Ace")
        return true
      else
        return false
      end
    end
  end

  def find_ace_count
    find_base_count <= 11 ? 10 : 0
  end

  def find_count
    if ace?
      find_base_count + 10 <= 21 ? find_base_count + 10 : find_base_count
    else
      find_base_count
    end
  end

  def busted?
    find_count > 21
  end
end

class Participant
  include CardCount

  attr_accessor :name, :cards

  def initialize
    @cards = []
    set_name
  end

  def add_card(card)
    cards.push(card)
  end

  def show_cards
    puts ""
    puts "#{name}'s cards are:"
    puts cards
    puts ""
    puts "#{name}'s total is #{find_count}."
    puts ""
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value"
    end
    self.name = name
  end
end

class Dealer < Participant
  ROBOTS = ['R2D2', "Hal", "Chappie", "Sonny", "Ziggy"].freeze

  def set_name
    self.name = ROBOTS.sample
  end

  def show_partial_hand
    puts "#{name}'s first card is:"
    puts cards.first
    puts ""
    puts "#{name}'s total is ????"
    puts ""
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer, :someone_won

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @someone_won = false
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
    self.someone_won = false
  end

  def deal_hand
    2.times do
      player.add_card(deck.deal_card)
      dealer.add_card(deck.deal_card)
    end
  end

  def hit_or_stay?
    puts "Would you like to (h)it or (s)tay?"
    loop do
      answer = gets.chomp.downcase
      if answer == "h" || answer == "hit"
        return "h"
      elsif answer == "s" || answer == "stay"
        puts "You stay!"
        return "s"
      else
        puts "Please enter (h)it or (s)tay."
      end
    end
  end

  def hit(participant)
    participant.add_card(deck.deal_card)
  end

  def player_lost
    puts ""
    puts "Sorry #{player.name}. You busted!"
    puts "Dealer won!"
    puts ""
  end

  def dealer_lost
    puts ""
    puts "Dealer busted!"
    puts "You won!"
    puts ""
  end

  def player_turn
    until hit_or_stay? == "s"
      hit(player)
      player.show_cards
      dealer.show_partial_hand
      if player.busted?
        self.someone_won = true
        break
      else
        next
      end
    end
  end

  def dealer_turn
    puts ""
    puts "Dealer's turn!"
    until dealer.find_count >= 17
      hit(dealer)
      puts "Dealer gets another card..."
      if dealer.busted?
        dealer.show_cards
        self.someone_won = true
        break
      else
        next
      end
      puts "Dealer stays!"
      puts " "
    end
  end

  def dealer_won?
    21 - dealer.find_count < 21 - player.find_count
  end

  def player_tie?
    21 - dealer.find_count == 21 - player.find_count
  end

  def congratulate_winner
    if dealer_won?
      puts "Dealer won!"
    elsif player_tie?
      puts "It's a tie!"
    else
      puts "Player won!"
    end
  end

  def play_again?
    puts "Would you like to play again (y/n)"
    answer = ""
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n', 'yes', 'no'].include?(answer)
    end
    if answer == 'y' || answer == "yes"
      true
    else
      false
    end
  end

  def play
    loop do
      system 'clear'
      deal_hand
      player.show_cards
      dealer.show_partial_hand
      player_turn
      if someone_won
        player_lost
      else
        dealer_turn
        if someone_won
          dealer_lost
        end
      end
      if someone_won
        if play_again?
          reset
          next
        else
          break
        end
      end
      player.show_cards
      dealer.show_cards
      congratulate_winner
      play_again? ? reset : break
    end
    puts "Thanks for playing 21!"
    puts "Goodbye!"
  end
end

game = TwentyOne.new
game.play
