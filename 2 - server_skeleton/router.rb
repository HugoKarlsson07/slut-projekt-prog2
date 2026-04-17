
require_relative 'regex.rb'

class Router
  attr_reader  :routes ,:block
  def initialize()
    @routes = []
  end
  def get(resource, &block)
    resource_reg = reg(resource)
    @routes << {resource: resource_reg, method: "GET", block: block} 
  end
  def post(resource, &block)
    resource_reg = reg(resource) 
    @routes << {resource: resource_reg, method: "POST",block: block}
  end


  def request_params(request)
    if request.headers.has_key?("Content-Length") 
        headers_length = request.headers["Content-Length"] 
        något = session.gets(headers_length.to_i)
    end
  end

  #Prints to the session
  #
  # @params request [hash] the hash contains the request 
  # @params block [string] contains the body of the http request
  # @params found [boolean] The status 
  # @return [found] 
  def responde_routing(request)
    found = false
    @routes.each do |r| 
      if request.resource.match?(r[:resource]) && request.method == r[:method]
        äpple = request.resource.match(r[:resource])
        @block = r[:block].call(*äpple.captures)
        found = true
      end
      if found 
        break
      end
    end
    return found
  end


end
