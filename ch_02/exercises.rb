# Exercise 1
# Create a class called MyCar. When you initialize a new instance or object of
# the class, allow the user to define some instance variables that tell us the
# year, color, and model of the car. Create an instance variable that is set to
# 0 during instantiation of the object to track the current speed of the car as
# well. Create instance methods that allow the car to speed up, brake, and shut
# the car off.

# Exercise 2
# Add an accessor method to your MyCar class to change and view the color of
# your car. Then add an accessor method that allows you to view, but not modify,
# the year of your car.

# Exercise 3
# You want to create a nice interface that allows you to accurately describe the
# action you want your program to perform. Create a method called spray_paint that
# can be called on an object and will modify the color of the car.

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

  def brake
    "Hitting the brakes"
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
end

gypsy = MyCar.new(2002, "blue", "volvo")
p gypsy.speed_up(20)
p gypsy.brake
p gypsy.off
p gypsy.display_year
gypsy.spray_paint
