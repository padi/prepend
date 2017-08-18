# rubocop:disable all

# This demonstrates a trick to adding new behavior on top of existing
# methods in Ruby, which is used repeatedly in Rails' source

# I have a Thing class that `include`-s module A,B,
# both of which override #print method and still calls
# super to retain the ancestors behavior

module A
  def print
    puts 'A'
    super
  end
end

module B
  def print
    super
    puts 'B'
  end
end

class Parent
  def print
    puts 'Thing'
  end
end

class Thing < Parent
  include A, B
end

Thing.new.print

Thing.ancestors # => [Thing, A, B, Parent, Object, PP::ObjectMixin, Kernel, BasicObject]

# >> A
# >> Thing
# >> B

