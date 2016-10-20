# What is a module? What is its purpose? How do we use them with our classes?
# Create a module for the class you created in exercise 1 and include it properly.

# A module is a collecction of behaviors that is useable in other classes via
# mixins.

# A module is "mixed in" to a class using the include reserved word

# A module is used to group common methods so that they can be used in different
# classes.

# Modules are also used for name spacing. When used for name spacing you will see
# ::

module MyModule
  def greeting(name)
    puts "Hello #{name}!"
  end
end


class ClassName # make sure the name of the class is CamelCase
  include MyModule
end


new_object = ClassName.new
new_object.greeting("Sam")