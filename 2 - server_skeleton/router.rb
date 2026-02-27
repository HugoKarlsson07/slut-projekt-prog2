class Router
  attr_reader  :routes
  def initialize()
    @routes = []
  end
  def get(resource)
    content = yield
    @routes << {resource: resource, method: "get", html: content} 
  end
  def post(resource)
    content = yield
    @routes << {resource: resource, method: "POST",html: content}
  end
end