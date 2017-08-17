# rubocop:disable all
require 'erb'

temp = "<p><%= @var %></p>"

erb = ERB.new(temp)
@var = "hi" 
erb.result(binding) # => "<p>hi</p>"
