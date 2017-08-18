# rubocop:disable all
#
# This demonstrates sinatra's `get`
# method and how it can be implemented
# so that it's return value can be
# passed back to the Rack specification's
# respond body
@routes = {}

def get(path, &block)
  @routes[path] = block
end

get('/') do
  'something'
end

get('/hi') do
  'hello'
end

# At the heart of a Rack app is this line in
# config.ru: run <anything that responds to #call(env)>
#
# It can be as simple as a ruby lambda.
# You can also find this in Rails apps, but instead it shows this:
#
#     require ::File.expand_path('../config/environment',  __FILE__)
#     run Rails.application

# You can be sure that `Rails.application` responds to #call
# It just does so much more than this example.

run ->(env) { # ~> NoMethodError: undefined method `run' for main:Object
  path = env['REQUEST_PATH']
  block = @routes[path] # resolves if there is path the leads to a proc
  if block
    [200, {"Content-Type" => 'text/html'}, [instance_eval(&block)]]
  else
    [400, {"Content-Type" => 'text/html'}, ['Not found']]
  end
}

