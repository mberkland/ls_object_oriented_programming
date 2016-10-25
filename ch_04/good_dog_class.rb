module Swimmable
  def swim
    "I'm swimming"
  end
end

class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "Hello!"
  end
end

class Mammal < Animal
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end

  def speak
    super + " from GoodDog class"
  end
end

class BadDog < Animal

  def initialize(age, name)
    super(name)
    @age = age
  end
end

class Fish
  include Swimmable
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end

sparky = GoodDog.new("black")
paws = Cat.new("Harold")
bruno = GoodDog.new("brown")


puts sparky.speak
puts paws.speak
p bruno
p BadDog.new(2, "bear")


sparkie = Dog.new("Sparkie")
neemo = Fish.new
paws = Cat.new("Paws")

p sparkie.swim
p neemo.swim
# paws.swim

module Walkable
  def walk
    "I'm walking"
  end
end

module Climbable
  def climb
    "I'm climbing"
  end
end

class Animals
  include Walkable

  def speaks
    "I'm an animal and I speak!"
  end
end

puts "---Animals method lookup---"
puts Animals.ancestors

fido = Animals.new
puts fido.speaks
puts fido.walk
# puts fido.swim

class GoodDogs < Animals
  include Swimmable
  include Climbable
end

puts "---GoodDogs method lookup---"
puts GoodDogs.ancestors

module Mammals
  class Dogs
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cats
    def say_name(name)
      p "#{name}"
    end
  end
end

buddy = Mammals::Dogs.new
kitty = Mammals::Cats.new

buddy.speak("Arf!")
kitty.say_name("kitty")

module MammalMethods
  def self.some_out_out_of_place_method(num)
    num ** 2
  end
end

value = MammalMethods.some_out_out_of_place_method(4)
p value

class OldDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  private

  def human_years
    age * DOG_YEARS
  end
end

bones = OldDog.new("")