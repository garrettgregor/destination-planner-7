class Giphy
  attr_reader :url

  def initialize(data)
    @url = data[:data][0][:images][:original][:url]
  end
end
