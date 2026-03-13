require_relative 'tcp_server.rb' 
require_relative 'router.rb'
require 'slim'

rut = Router.new #router behöver spara method och resorce




rut.get("/wat") do
  File.read("views/test.html") #själva sökvägen
end



rut.get("/ha/:id") do |korv|
  "<h1> #{korv.to_i} </h1>"
end


# rut.get("/post") do
#   korv = params["wat"]
#   bröd = params["wot"]
#   "<h1> #({"korv"}) </h1>"
#   "<h1> #({"bröd"}) </h1>"
# end





server = HTTPServer.new(4567, rut.routes)
server.start


