require 'spec_helper'
require_relative '../bin/http_response'

RESPONSE1 = %{HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Tue, 06 May 2014 02:17:16 GMT
Content-Type: text/html
Last-Modified: Sun, 27 Apr 2014 04:03:41 GMT
Transfer-Encoding: chunked
Connection: keep-alive
Content-Encoding: gzip

<!DOCTYPE html>
          <html lang="en">
<head><meta charset="utf-8" />
<meta name="description" content="should i test private methods?" />
<meta name="keywords" content="test,private,methods,oo,object,oriented,tdd" />
<title>Should I Test Private Methods?</title>
    </head>
<body>
<div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div>
      <!-- Every time you consider testing a private method, your code is telling you that you haven't allocated responsibilities well.  Are you listening to it? -->
    </body>
</html>}

RESPONSE2 = %{HTTP/1.1 200 OK
Server: nginx
Date: Tue, 06 May 2014 02:15:51 GMT
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
Connection: keep-alive
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Access-Control-Allow-Methods: GET, POST

{"coord":{"lon":-0.13,"lat":51.51},"sys":{"message":0.0346,"country":"GB","sunrise":1399350122,"sunset":1399404728},"base":"cmc stations"}}

describe HttpResponse do
  it "returns a hash of headers" do
    response = HttpResponse.new(RESPONSE1)
    actual = response.headers
    expected = {
      :server => "nginx/1.4.6 (Ubuntu)",
      :date => "Tue, 06 May 2014 02:17:16 GMT",
      :content_type => "text/html",
      :last_modified => "Sun, 27 Apr 2014 04:03:41 GMT",
      :transfer_encoding => "chunked",
      :connection => "keep-alive",
      :content_encoding => "gzip"
    }

    expect(actual).to eq expected

  end

  it "returns the body of the response" do
    response = HttpResponse.new(RESPONSE1)
    actual = response.body
    expected = %{<!DOCTYPE html>
          <html lang="en">
<head><meta charset="utf-8" />
<meta name="description" content="should i test private methods?" />
<meta name="keywords" content="test,private,methods,oo,object,oriented,tdd" />
<title>Should I Test Private Methods?</title>
    </head>
<body>
<div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div>
      <!-- Every time you consider testing a private method, your code is telling you that you haven't allocated responsibilities well.  Are you listening to it? -->
    </body>
</html>}

    expect(actual).to eq expected
  end

  it "returns the response code" do
    response = HttpResponse.new(RESPONSE1)
    actual = response.status_code
    expected = 200
    expect(actual).to eq expected
  end

  it "returns nil if content type is not json, else nil" do
    response = HttpResponse.new(RESPONSE1)
    actual = response.response_json
    expected = nil
    expect(actual).to eq expected
  end

  it "returns ruby hash of body if content type is json" do
    response = HttpResponse.new(RESPONSE2)
    actual = response.response_json
    expected = {
      "coord" => {
        "lon" => -0.13,
        "lat" => 51.51
      },
      "sys" => {
        "message" => 0.0346,
        "country" => "GB",
        "sunrise" => 1399350122,
        "sunset" => 1399404728
      },
      "base" => "cmc stations"
    }

    expect(actual).to eq expected
  end
  it "saves body in temp folder if content type is text" do
    if File.exist?("./tmp/test.html")
      File.delete("./tmp/test.html")
    end
    response = HttpResponse.new(RESPONSE1)
    response.response_html
    actual = File.read(File.new("./tmp/test.html"))
    expected = %{<!DOCTYPE html>
          <html lang="en">
<head><meta charset="utf-8" />
<meta name="description" content="should i test private methods?" />
<meta name="keywords" content="test,private,methods,oo,object,oriented,tdd" />
<title>Should I Test Private Methods?</title>
    </head>
<body>
<div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div>
      <!-- Every time you consider testing a private method, your code is telling you that you haven't allocated responsibilities well.  Are you listening to it? -->
    </body>
</html>\n}

    expect(actual).to eq expected

  end
end