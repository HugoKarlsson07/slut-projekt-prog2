

def reg(string)
  x = string
  if x.match?(/(\/:\w+)+/)
    x = x.gsub(/\/\:\w+/, "\/(\\w+)+")
    y = Regexp.new(x)
    return y
  else
    x = "^" + x + "$"
    y = Regexp.new(x)
    y = Regexp.new("^#{x}&")
  end
end


