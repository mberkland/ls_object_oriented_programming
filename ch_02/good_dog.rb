class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says Arf!"
  end

  def describe
    puts "#{self.name} is #{self.weight} lbs."
    puts "#{self.name} is #{self.height} inches high."
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
end

sparky = GoodDog.new("Sparky", 52, 18)
puts sparky.speak


fido = GoodDog.new("Fido", 32, 15)
puts fido.speak
puts sparky.name
sparky.name = "Sparticus"
puts sparky.name
sparky.describe

sparky.change_info("Sparkels", 12, 9)
sparky.describe