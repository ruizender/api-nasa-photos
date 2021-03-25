#pOW0JKHr7zjGihPLF5aAACQ6N9LcNWOU6uFaw02Y

require "uri"
require "net/http"
require "json"
require "openssl"

def buid_web_page(page_creator)
    api_key ="pOW0JKHr7zjGihPLF5aAACQ6N9LcNWOU6uFaw02Y"
    url = URI(page_creator + api_key)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(url)
    response = https.request(request)

    documents = JSON.parse (response.read_body)
    
    nasa_img = []
    
    documents["photos"].count.times {|x| nasa_img.push documents["photos"][x]["img_src"]}
    
    list = ""
    nasa_img.count.times {|x| list += "<li><img src=#{nasa_img[x]}></li>" } 
    
    last_html = '<!DOCTYPE html>
    <html lang="es">
    <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>' +
    "</head>
    <body>
    <ul>
    #{list}
    </ul>
    </body>
    </html>"
    File.write('index.html', last_html)
    
    
end 

buid_web_page("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=")
    
