require 'rubygems'
require 'open-uri'
require 'json'
require 'hpricot'

class BestApp
  def load(id)
    @id = id
    @doc = open("http://bestc.am/photographers/#{id}"){ |f| Hpricot(f) }
  end

  def name 
    (@doc/"#sidebar/div/h2/a").html
  end

  def web
    (@doc/"#sidebar/h4/a").attr('href')
  end

  def images
    (@doc/"#photo_list/li/div/div").collect {|div| {:src => div.attributes['style'].match(/background-image: url\("([^")]+)"\)/)[1], :href => div.find_element('a').attributes['href']}}
  end

  def id 
    @id
  end

  def to_json
    {:id => id, :name => name, :web => web, :images => images[0..3], :count => images.size}.to_json
  end

end

app = proc do |env|
  path = env['PATH_INFO']
  case path
  when '/'
    return [200, { "Content-Type" => "text/html" }, 'hello world']
  when /[0-9]+\.js/
    photographer = path.match(/\/([0-9]+).js/)[1]
    best = BestApp.new
    best.load(photographer)
    return [200, { "Content-Type" => "text/javascript" }, "var bestcam_data = #{best.to_json}"]
  else
    return [ 401, { "Content-Type" => "text/html" }, '401: File not found' ]
  end
end
run app
