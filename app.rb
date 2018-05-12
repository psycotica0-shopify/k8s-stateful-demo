require 'sinatra'
require 'socket'
require 'net/http'

get '/' do
  "Test words\n"
end

get '/id' do
  Socket.gethostname + "\n"
end

def f(x)
  File.join("/saved", x)
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

get '/from/:host/:name' do
  Net::HTTP.get(params['host'] + ".headless-service.default.svc.cluster.local.", "/data/" + params['name'], 4567)
end
