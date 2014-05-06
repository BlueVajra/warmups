class HttpResponse
  def initialize(response)
    @response = response
    @response_array = @response.split("\n\n")
  end

  def headers

    headers_array = @response_array.first.split("\n")
    headers_array.shift
    headers_array.map! { |header| header.split(": ") }
    headers_array.to_h
  end

  def body
    @response_array.last
  end
end