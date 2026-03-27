require 'socket'
require_relative 'lib/request.rb'
require 'slim'
require_relative'response.rb'
require_relative'help.rb'

class HTTPServer

  def initialize(port, rout)
    @port = port
    @route = rout
    @routes = [] unless @routes.is_a?(Array)
    @mime_map = mime()
    
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
      @route.request_params(request)
      res = @route.responde_routing(request)
      
      status = 404
      block = "<h1> Error #{status} </h1>"
      content = "text/html"

      path = "./public#{request.resource}"

      if res 
        status = 200
        block = @route.block 
      elsif File.exist?(path) == true  && File.file?(path)
        _, file_ending = request.resource.split(".") 
        content = @mime_map[file_ending]
        block = File.binread(path) 
        status = 200
      end
      
      response = Response.new(request,session)
      response.responde(status, block, content)

      

      
    end
  end
end
