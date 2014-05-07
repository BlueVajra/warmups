require 'json'
require 'launchy'

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

  def response_html
    if @headers[:content_type].include?("text")
      File.open("./tmp/test.html", "w") do |file|
        file.puts(@body)
      end
      Launchy.open("./tmp/test.html")
    end
  end

  private

  def parse_response(response)
    response_array = response.split("\n\n")
    headers_array = response_array.first.split("\n")
    @status_code = headers_array.shift.match(/\d{3}/)[0].to_i
    @headers = convert_headers_to_hash(headers_array)
    @body = response_array.last
  end

  def convert_headers_to_hash(array)
    array.map! { |header| header.split(": ") }
    symbolized_array = array.map do |entry|
      [symbolize_key(entry[0]), entry[1]]
    end
    symbolized_array.to_h
  end

  def symbolize_key(key)
    key.downcase.gsub('-', '_').to_sym
  end

end