class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age, :height, :weight

  @@number_of_dogs = 0

  def initialize(n, a, h = "15 inches", w = "20 lbs")
    @@number_of_dogs += 1
    self.name = n
    self.age = a * DOG_YEARS
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def self.what_am_i
    "I'm a GoodGod class!"
  end

  def info
    "#{self.name} weights #{self.weight} and is self.height} tall"
  end

  def what_is_self
    self
  end

  # def to_s   # use this to over ride the normal to_s instance method
  #   "This dog's name is #{name} and it is #{age} in dog years"
  # end
end

puts GoodDog.total_number_of_dogs

sparky = GoodDog.new("Sparky", 4)
puts sparky.age
puts GoodDog.total_number_of_dogs
puts sparky # uncomment the to_s instance method to see difference
sparky = GoodDog.new('Sparky', 4, '12 inches', '10 lbs')
p sparky.what_is_self

