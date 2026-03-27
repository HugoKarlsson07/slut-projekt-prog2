
class Response
  
  def initialize(request, session)
    @session = session
    @request = request
  end

  def responde(status, block, content)
    p block
    content_length = block.bytesize
    @session.print "HTTP/1.1 #{status}\r\n"
    @session.print "Content-Type: #{content}\r\n"
    @session.print "Content-Length: #{content_length}\r\n"
    @session.print "\r\n"
    @session.print block
    @session.close
  end
end
