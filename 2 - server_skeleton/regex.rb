

def reg(string)
  x = string
  if x.match?(/(\/:\w+)+/)
    x = x.gsub(/\/\:\w+/, "\/(\\w+)+")
    y = Regexp.new(x)
    return y
  else
    y = Regexp.new("^#{x}&")
  end
end


