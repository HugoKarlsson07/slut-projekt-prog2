require_relative 'tcp_server.rb' 

my_routes = [
  { 
    resource: "/hello", 
    html: "<h1>Hello, World!</h1>" 
  },
  { 
    resource: "/wat", 
    html: "<h1>WAT!</h1>" 
  },
  { 
    resource: "/minipekka/pancake", 
    html: File.read("views/test.html") 
  }
]



server = HTTPServer.new(4567, my_routes)

server.start