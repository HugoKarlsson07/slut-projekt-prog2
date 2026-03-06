class Router
  attr_reader  :routes
  def initialize()
    @routes = []
  end
  def get(resource, &block)
    @routes << {resource: resource, method: "GET", block: block} 
  end
  def post(resource, &block) 
    @routes << {resource: resource, method: "POST",block: block}
  end
end
