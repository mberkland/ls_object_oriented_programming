# Exercise 1
# Add a class method to your MyCar class that calculates the gas mileage of
# any car.

# Exercise 2
# Override the to_s method to create a user friendly print out of your object.


class MyCar
  attr_accessor :color, :speed
  attr_reader :make, :year

  def initialize(y, c, m, s=0)
    @year = y
    @color = c
    @make = m
    @speed = s
  end

  def speed_up(increase)
    self.speed += increase
    "The new speed is #{self.speed}"
  end

  def display_year
    "The car was made in #{self.year}"
  end

  def brake(decrease)
    self.speed -= decrease
    "The new speed is #{self.speed}"
  end

  def off
    self.speed = 0
    "The speed is now #{self.speed}"
  end

  def spray_paint
    puts "What color do you want to repaint the car?"
    new_color = gets.chomp
    self.color = new_color
    puts "The car's color is now #{self.color}!"
  end

  def self.calculate_gas_mileage(miles, gallons)
    "You gas mileage is #{miles/gallons}"
  end

  def to_s
    "The car is as #{year} #{color} #{make} and it is currently traveling at #{speed} mph"
  end
end

car1 = MyCar.new(2002, "red", "Chevy Mustang", 80)

p MyCar.calculate_gas_mileage(351, 13)
puts car1

# Exercise 3
# When running the following code...

# class Person
#   attr_reader :name
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Steve")
# bob.name = "Bob"

# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
# <Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how to we fix it?

# Class person uses attr_reader, which is like setting a getter method only
# However inside the initialize method there is an attempt to reassign or set
# the name instance variable to the paramater that is passed in.
# This can only be done though if the instance variable has a setter method already
# defined. Since it doesn't a nomethod error occurs becaue there is no 'name='
# setter method defined
# To fix this, attr_reader should be changed to attr_accessor