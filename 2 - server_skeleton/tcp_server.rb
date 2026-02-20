require 'socket'
require_relative 'lib/request.rb'
require_relative 'lib/mime.rb'

class HTTPServer

  def initialize(port, rout)
    @port = port
    @routes = rout
    @routes = [] unless @routes.is_a?(Array)
  end

  def get(routing) #routing är en sträng som vi vill tildella resorce

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

      p "++++++++++++++++++++++++++"
      p request.inspect
      p "++++++++++++++++++++++++++"

      #är det en post?
      #kolla i content-length(????) (headers)
      #banan = session.gets(så många bytes som det var)
      #vad finns nu i banan? vad ska du göra med bananen?

      status = 404
      content = "text/html"
      what = 0
      mime_map = parse_mime_table()

      p request.resource
      html = "<h1> Error #{status} </h1>"
      route = @routes.find { |r| r[:resource] == request.resource }

      if route
        html = route[:html]
        status = 200
        p html
      else
        if File.exist?("./public#{request.resource}") == true
          _, file_ending = request.resource.split(".")
          content = mime_map[file_ending]
          html = File.binread("./public#{request.resource}") 
          status = 200
        end
      end
      content_length = html.bytesize
      session.print "HTTP/1.1 #{status}\r\n"
      session.print "Content-Type: #{content}\r\n"
      session.print "Content-Length: #{content_length}\r\n"
      session.print "\r\n"
      session.print html
      session.close
    end
  end
end

# server = HTTPServer.new(4567)
# server.start
