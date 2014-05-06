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

describe HttpResponse do
  it "returns a hash of headers" do
    response = HttpResponse.new(RESPONSE1)
    actual = response.headers
    expected = {
      "Server" => "nginx/1.4.6 (Ubuntu)",
      "Date" => "Tue, 06 May 2014 02:17:16 GMT",
      "Content-Type" => "text/html",
      "Last-Modified" => "Sun, 27 Apr 2014 04:03:41 GMT",
      "Transfer-Encoding" => "chunked",
      "Connection" => "keep-alive",
      "Content-Encoding" => "gzip"
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
end