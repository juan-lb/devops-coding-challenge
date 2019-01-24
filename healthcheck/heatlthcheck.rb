require "rack"
require "thin"
require 'net/http'


class HelloWorld

  REFRESH_TIME =  ENV.fetch("REFRESH_TIME") { 5 }
  WEBSITE      =  ENV.fetch("WEBSITE") { 'http://www.google.com/' }


  def call(env)
    [ 200, { "Content-Type" => "text/html" }, [html_response] ]
  end
  
  private
  
  def html_response
    content = healthcheck_response
    "#{html_header}#{html_body(content)}"
  end 
  
  def html_body(content)
  "<h3>Checking: #{WEBSITE}</h3><br/>#{DateTime.now} - Status: #{content}"
  end
  
  def html_header
    "<head><meta http-equiv='refresh' content='#{REFRESH_TIME}'></head>"
  end
  
  def healthcheck_response
    if is_200?
      "OK"
    else
      "FAIL"
    end
  end
  
  def is_200?
    puts "Checking: #{WEBSITE}" 
    uri = URI(WEBSITE)
    res = Net::HTTP.get_response(uri)
    res.is_a?(Net::HTTPSuccess)
  rescue
    false
  end
  
end

Rack::Handler::Thin.run(HelloWorld.new, Host: '0.0.0.0')


