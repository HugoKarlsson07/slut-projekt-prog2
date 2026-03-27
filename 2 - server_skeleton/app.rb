require_relative 'tcp_server.rb' 
require_relative 'router.rb'
require 'slim'

rut = Router.new 


rut.get("/wat") do
  File.read("views/test.html") 
end

rut.get("/") do
  "<h1> Jag vill äta mat!!!!!!!!!  </h1>"
end


rut.get("/ha/:id") do |korv|
  "<h1> #{korv.to_i} </h1>"
end



server = HTTPServer.new(4567, rut)
server.start


