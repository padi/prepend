# rubocop:disable all
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

run ->(env) {
  path = env['REQUEST_PATH']
  block = @routes[path] # resolves if there is path the leads to a proc
  if block
    [200, {"Content-Type" => 'text/html'}, [instance_eval(&block)]]
  else
    [400, {"Content-Type" => 'text/html'}, ['Not found']]
  end
}
