require 'json'

class HttpResponse
  attr_reader :headers, :body, :status_code

  def initialize(response)
    parse_response(response)
  end

  def response_json
    if @headers[:content_type].include?("json")
      JSON.parse(@body)
    end
  end

  private

  def parse_response(response)
    response_array = response.split("\n\n")
    headers_array = response_array.first.split("\n")
    @status_code = headers_array.shift.match(/\d{3}/)[0].to_i
    headers_array.map! { |header| header.split(": ") }
    @headers = convert_headers_to_hash(headers_array)
    @body = response_array.last
  end

  def convert_headers_to_hash(array)
    symbolized_array = array.map do |entry|
      [symbolize_key(entry[0]), entry[1]]
    end
    symbolized_array.to_h
  end

  def symbolize_key(key)
    key.downcase.gsub('-', '_').to_sym
  end

end