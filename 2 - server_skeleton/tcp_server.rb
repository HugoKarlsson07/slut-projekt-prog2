require 'socket'
require_relative 'lib/request.rb'

class HTTPServer

  def initialize(port)
    @port = port
  end


  def start
    server = TCPServer.new(@port)
    puts "Listening on #{@port}"

    while session = server.accept
      data = ''
      while line = session.gets and line !~ /^\s*$/
        data += line
      end
      puts "RECEIVED REQUEST"
      puts '-' * 40
      puts data
      puts '-' * 40

      request = Request.new(data)
     
    

      routes = [{resource: "/hello", html: "<h1>Hello, World!</h1>" },{resource: "/wat", html: "<h1>WAT!</h1>" },{resource: "/minipekka/pancake", html: File.read("views/test.html") }]

      

      status = 404
      content_type = "html"
      what = 0


      html = "<h1> Error #{status} </h1>"
      found = 0
      routes.each do |rot|
       if  request.resource == rot[:resource] 
        html = rot[:html]
        status = 200
        found = 1
       end
      end
      if found == 0
        if File.exist?("./public#{request.resource}") == true
          url_type = request.resource.split(".")
          url_type = url_type[1]
          html = File.read("./public#{request.resource}") #användaren måste specifiera filtyp
          status = 200
        end
      end
       

      session.print "HTTP/1.1 #{status}\r\n"
      session.print "Content-Type: text/#{content_type}\r\n"
      session.print "\r\n"
      session.print html
      session.close
    end
  end
end

server = HTTPServer.new(4567)
server.start
