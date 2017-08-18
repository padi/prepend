# rubocop:disable all
# This is an simplification of the real-world
# example of "adding a Metal class"-trick:
# How Rails includes modules to ActionController::Base
# that adds behavior on top of existing behavior.

# Suppose AC::Base has a filtering module
require './filtering'

module ActionController; end # define namespace

# AC::Metal has a #process method
# that by default just calls the correct
# controller-action, among other things.
# The actual Rails source code might do more.
class ActionController::Metal
  def process
    index # send(:index) or any send(action)
  end
end

# Instead of adding #process to Base, we add it to
# AC::Metal, so that Filtering#process that calls
# `super` can be executed without completely
# overring AC::Base#process behavior
class ActionController::Base < ActionController::Metal
  include Filtering
end

# Here's a typical structure of a Rails
# controller that inherits from our fake AC::Base,
# which uses the *_action methods (defined in Filtering)
# module
class HelloController < ActionController::Base
  before_action :filter
  after_action :filter_again

  def index
    puts 'index'
  end

  private

  def filter
    puts 'filter'
  end

  def filter_again
    puts 'filter_again'
  end
end

# Finally let's check if this works!
HelloController.new.process

# TADA!
# >> filter
# >> index
# >> filter_again
