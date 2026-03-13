

def reg(string)
  x = string.to_s
  x = x.gsub(/:\w+/, "(\\w+)")
  y = Regexp.new(x)
end



