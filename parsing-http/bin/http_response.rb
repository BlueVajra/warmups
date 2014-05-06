class HttpResponse
  def initialize(response)
    @response = response
  end

  def headers
    response_array = @response.split("\n\n")
    headers_array = response_array.first.split("\n")
    headers_array.shift
    headers_array.map! { |header| header.split(": ") }
    headers_array.to_h
  end
end