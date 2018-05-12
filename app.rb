require 'sinatra'
require 'socket'

get '/' do
  "Test words\n"
end

get '/id' do
  Socket.gethostname + "\n"
end

def f(x)
  File.join("./", x)
end

get '/data/:name' do
  begin
    File.read(f(params['name'])) + "\n"
  rescue
    [404, ""]
  end
end

post '/data/:name' do
  File.open(f(params['name']), "w") do |file|
    file.write(request.body.read)
  end
end
