require_relative'help.rb'
class Response
  
  def initialize(request, routes, session)
    @routes = routes
    @session = session
    @request = request
    @status = 404
    @content = "text/html"
    @html = "<h1> Error #{status} </h1>"
    @mime_map = mime()
    @found = false
  end

  def responde()
    content_length = @html.bytesize
    @session.print "HTTP/1.1 #{@status}\r\n"
    @session.print "Content-Type: #{@content}\r\n"
    @session.print "Content-Length: #{content_length}\r\n"
    @session.print "\r\n"
    @session.print @html
    @session.close
  end

  

  def request_params()
    if request.headers.has_key?("Content-Length") 
        headers_length = request.headers["Content-Length"] 
        något = session.gets(headers_length.to_i)
    end
  end
  
  def responde_routing()
    route = @routes.each do |r| 
        if request.resource.match?(r[:resource]) && request.method == r[:method]
          äpple = request.resource.match(r[:resource])
          html = r[:block].call(*äpple.captures)
          status = 200
          found = true
          p found
        end
    end
      path = "./public#{request.resource}"
      if !found && File.exist?("./public#{request.resource}") == true  && File.file?(path)
        _, file_ending = request.resource.split(".") 
        content = mime_map[file_ending]
        html = File.binread("./public#{request.resource}") 
        status = 200
      end 
  end
end
