# Exercise 1
# Create a superclass called Vehicle for your MyCar class to inherit from and
# move the behavior that isn't specific to the MyCar class to the superclass.
# Create a constant in your MyCar class that stores information about the vehicle
# that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass that
# also has a constant defined that separates it from the MyCar class in some way.

# Exercise 2
# Add a class variable to your superclass that can keep track of the number of
# objects created that inherit from the superclass. Create a method to print out
# the value of this class variable as well.

# Exercise 3
# Create a module that you can mix in to ONE of your subclasses that describes a
# behavior unique to that subclass.

# Exercise 4
# Print to the screen your method lookup for the classes that you have created.

# Exercise 5
# Move all of the methods from the MyCar class that also pertain to the MyTruck
# class into the Vehicle class. Make sure that all of your previous method calls
# are working when you are finished.

# Exercise 6
# Write a method called age that calls a private method to calculate the age of
# the vehicle. Make sure the private method is not available from outside of the
# class. You'll need to use Ruby's built-in Time class to help.

module Loadable
  def load
    "I'm hauling stuff"
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :make, :year

  @@number_of_vehicles = 0

  def initialize(y, c, m, s=0)
    @@number_of_vehicles += 1
    @year = y
    @color = c
    @make = m
    @speed = s
  end

  def self.total_number_of_vehicles
    "There are #{@@number_of_vehicles} total vehicles"
  end

  def age
    "The #{self.make} is #{years_old} years old"
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
    "Your gas mileage is #{miles/gallons}"
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "The car is as #{year} #{color} #{make} and it is currently traveling at #{speed} mph."
  end
end

class MyTruck < Vehicle
  include Loadable

  NUMBER_OF_DOORS = 2

  def to_s
    "The truck is as #{year} #{color} #{make} and it is currently traveling at #{speed} mph."
  end
end

p Vehicle.total_number_of_vehicles

car1 = MyCar.new(2002, "red", "Chevy Mustang", 80)
truck1 = MyTruck.new(2014, "black", "Ford F-150", 55)

p MyCar.calculate_gas_mileage(351, 13)
puts car1
puts truck1

p Vehicle.total_number_of_vehicles

p Vehicle.ancestors
p MyCar.ancestors
p MyTruck.ancestors

p car1.age
p truck1.age

# Exercise 7
# Create a class 'Student' with attributes name and grade. Do NOT make the grade
# getter public, so joe.grade will raise an error. Create a
# better_grade_than? method, that you can call like so...
# puts "Well done!" if joe.better_grade_than?(bob)

class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    if grade > other_student.grade
      "Well done"
    else
      "That's too bad"
    end
  end

  protected

  def grade
    @grade
  end
end

harry = Student.new("Harry", 95)
paul = Student.new("Paul", 80)

p harry.better_grade_than?(paul)
p paul.better_grade_than?(harry)

harry.gradeGiven the following code...



# Exercise 8
# Given the following code:
# bob = Person.new
# bob.hi
# And the corresponding error message:
# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
# What is the problem and how would you go bout fixing it?


# The problem is that hi is a private method inside the Person class and can not
# be accessed when invoked upon an object of that class
# In order to invoke this method on an object of the Person class the hi method
# must be moved above the private delcaration inside the Person class