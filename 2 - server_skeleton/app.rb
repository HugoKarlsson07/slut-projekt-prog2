require_relative 'tcp_server.rb' 
require_relative 'router.rb'
require 'slim'
# my_routes = [
#   { 
#     resource: "/hello", 
#     html: "<h1>Hello, World!</h1>" 
#   },
#   { 
#     resource: "/wat", 
#     html: "<h1>WAT!</h1>" 
#   },
#   { 
#     resource: "/minipekka/pancake", 
#     html: File.read("views/test.html") 
#   },{ 
#     resource: "/submit-data", 
#     html: "<h1>Tack! Vi har tagit emot din data.</h1>" 
#   },
#   { 
#   method: "GET", 
#   resource: "/login", 
#   html: '<form action="/login" method="POST"><input type="text" name="username"> <input type="submit" value="Logga in"> </form>' 
# },

# { 
#   method: "POST", 
#   resource: "/login", 
#   html: "<h1>Du är nu inloggad (via POST)!</h1>" 
# },
# {
#   method: "GET", 
#   resource:"/wat"
#   html:       #sökvägen
  
# }
# ]


rut = Router.new #router behöver spara method och resorce


rut.get("/wat") do
  File.read("views/test.html") #själva sökvägen
end



rut.post("/wat") do

end






server = HTTPServer.new(4567, rut.routes)
server.start