

#ska retunera method resource version headers params
class Request
  attr_reader :method, :resource, :version, :headers, :params
  def initialize(fileContent)
   
    @content = fileContent
    @content = @content.split(/\r?\n/)

    #p(@content)

    row1, row2, row3, row4 = @content
    @method, @resource, @version = row1.split(" ")

    host, hoster = row2.split(": ")
    acc_lang, lang = row3.split(": ")
    @headers = {host => hoster, acc_lang => lang}
    @params = row4 = {}

  end
end
