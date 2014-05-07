require 'json'

class HttpResponse
  attr_reader :headers, :body, :status_code
  def initialize(response)
    parse_response(response)
  end

  def response_json
    if @headers["Content-Type"].include?("json")
      JSON.parse(@body)
    end
  end

  private

  def parse_response(response)
    response_array = response.split("\n\n")
    headers_array = response_array.first.split("\n")
    @status_code = headers_array.shift.match(/\d{3}/)[0].to_i
    headers_array.map! { |header| header.split(": ") }
    @headers = headers_array.to_h
    @body = response_array.last
  end

end