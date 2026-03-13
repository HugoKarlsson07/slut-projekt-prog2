require_relative 'regex.rb'

class Router
  attr_reader  :routes
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
end
