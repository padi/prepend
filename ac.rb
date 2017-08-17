# rubocop:disable all

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

