# rubocop:disable all
module A
  def print
    puts 'A'
    super
  end
end

module B
  def print
    puts 'B'
    super
  end
end

class Metal
  def print
    puts "Thing"
  end
end

class Thing < Metal
  include A, B
end

# Thing.new.print # => nil
# Thing.ancestors # => [Thing, A, B, Metal, Object, PP::ObjectMixin, Kernel, BasicObject]

module Filtering
  def process
    puts 'do before_filter'
    super # does AC::Base.process
    puts 'do after_filter'
  end
end

module AC; end

class AC::Metal
  def process
    puts 'AC::Base.process'
  end
end

#   class HelloController < ActionController::Metal
#     def index
#       self.response_body = "Hello World!"
#     end
#   end

class AC::Base < AC::Metal
  include Filtering
end

AC::Base.new.process # => nil

# >> do before_filter
# >> AC::Base.process
# >> do after_filter
