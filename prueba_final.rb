#pOW0JKHr7zjGihPLF5aAACQ6N9LcNWOU6uFaw02Y

require "uri"
require "net/http"
require "json"
require "openssl"

link_uri = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key="

apis_key ="pOW0JKHr7zjGihPLF5aAACQ6N9LcNWOU6uFaw02Y"

def method_json(link_uri, apis_key)
    url = URI(link_uri + apis_key)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse (response.read_body)
end

documents = method_json(link_uri, apis_key)

nasa_img = []
documents["photos"].count.times {|x| nasa_img.push documents["photos"][x]["img_src"]}

list = ""
nasa_img.count.times {|x| list = list + "<li><img src=#{nasa_img[x]}></li>" } 

#---- a partir de aqui la pregunta bonus
camera = []
documents["photos"].count.times {|x| camera.push(documents["photos"][x]["camera"]["name"])}

def photos_count(order)
    mast = 0
    fhaz = 0
    rhaz = 0
    chemcam = 0
    navcam = 0
    order.count.times do |i|
        if order[i] == "MAST"
            mast += 1
        elsif order[i] == "FHAZ"
            fhaz += 1
        elsif order[i] == "RHAZ"
            rhaz += 1
        elsif order[i] == "CHEMCAM"
            chemcam += 1
        else order[i] == "NAVCAM"
            navcam += 1
        end
    end 
    mensaje = "La camara MAST tomo #{mast} fotos,
    La camara FHAZ tomo #{fhaz} fotos,
    La camara RHAZ tomo #{rhaz} fotos,
    La camara CHEMCAM tomo #{chemcam} fotos,
    La camara NAVCAM tomo #{navcam} fotos."
end

fotos_totales = photos_count(camera)

#---- metodo de impresion de html
def buid_web_page(list, fotos_totales)
    '<!DOCTYPE html>
    <html lang="es">
    <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photos Rover</title>' +
    "</head>
    <body>
    <p>#{fotos_totales}</p>
    <ul>
    #{list}
    </ul>
    </body>
    </html>"
end 

File.write('index.html', buid_web_page(list, fotos_totales))