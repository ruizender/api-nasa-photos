#pOW0JKHr7zjGihPLF5aAACQ6N9LcNWOU6uFaw02Y

#https://api.nasa.gov/planetary/apod?api_key=pOW0JKHr7zjGihPLF5aAACQ6N9LcNWOU6uFaw02Y    ---- me lo dio nasa

require "uri"
require "net/http"
require "json"
api_key ="pOW0JKHr7zjGihPLF5aAACQ6N9LcNWOU6uFaw02Y"
url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=#{api_key}")
https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true
request = Net::HTTP::Get.new(url)
response = https.request(request)

documents = JSON.parse (response.read_body)





