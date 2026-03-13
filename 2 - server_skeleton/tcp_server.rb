require 'socket'
require_relative 'lib/request.rb'
require_relative 'lib/mime.rb'
require 'slim'

class HTTPServer

  def initialize(port, rout)
    @port = port
    @routes = rout
    @routes = [] unless @routes.is_a?(Array)
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

      if request.headers.has_key?("Content-Length") 
        headers_length = request.headers["Content-Length"] 
        något = session.gets(headers_length.to_i)
      end

      status = 404
      content = "text/html"
      what = 0
      mime_map = parse_mime_table()
      html = "<h1> Error #{status} </h1>"


      route = @routes.each do |r| 
        p r[:resource]
        p r[:method]
        p "------------------"
        p r
        p "------------------"
        if request.resource.match?(r[:resource]) && request.method == r[:method]
          äpple = request.resource.match(r[:resource])
          html = r[:block].call(*äpple.captures)
          status = 200
        else
          if File.exist?("./public#{request.resource}") == true
            _, file_ending = request.resource.split(".")
            content = mime_map[file_ending]
            html = File.binread("./public#{request.resource}") 
            status = 200
          end 
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
 