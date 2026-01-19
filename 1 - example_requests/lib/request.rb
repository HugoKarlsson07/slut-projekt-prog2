require 'debug'

#ska retunera method resource version headers params
class Request
  attr_reader :method, :resource, :version, :headers, :params
  def initialize(fileContent)
    @params = Hash.new
    @content = fileContent

    @content = @content.split(/\n\n/)
    param = @content[1]

    @content.delete_at(1)
    @content = @content[0]
    @content = @content.split(/\r?\n/)

    @method, @resource, @version = @content[0].split(" ")
    @content.delete_at(0)
    @headers = Hash.new

  
    @content.each do |header|
        if header.include?(": ")
          header = header.split(": ")
          @headers[header[0]] = header[1]
        end
    end

    if @method == "GET"
      holder = @resource
      holder = holder.split("?")
      holder.delete_at(0)
      holder = holder[0]
      holder = holder.split("&")
      holder.each do |param|
        param = param.split("=")
        @params[param[0]] = param[1]
      end
    elsif @method == "POST"
      param = param.split("&")
      param.each do |arg|
        arg = arg.split("=")
        @params [arg[0]] = arg[1]
      end
    end
  end
end
