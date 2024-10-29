# config/initializers/recombee.rb
require "net/http"
require "json"
require "uri"

RECOMBEE_BASE_URL = "https://rapi.recombee.com"
RECOMBEE_DATABASE_ID = "testecnico-dev"  # Cambia por tu Database ID
RECOMBEE_SECRET_TOKEN = "5vFHSqiRZT0KV3TJZDCD7tS25Od0pfHzsHiW21y3ItaisBliz5VPjFJPr6ho6im9"  # Cambia por tu Token Secreto

def recombee_request(endpoint, method, body = nil)
  uri = URI.parse("#{RECOMBEE_BASE_URL}/#{RECOMBEE_DATABASE_ID}/#{endpoint}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = case method
  when :post
              Net::HTTP::Post.new(uri.request_uri)
  when :get
              Net::HTTP::Get.new(uri.request_uri)
  end

  request["Authorization"] = "Bearer #{RECOMBEE_SECRET_TOKEN}"
  request["Content-Type"] = "application/json"
  request.body = body.to_json if body

  response = http.request(request)
  JSON.parse(response.body)
rescue => e
  puts "Error in Recombee request: #{e.message}"
  nil
end
