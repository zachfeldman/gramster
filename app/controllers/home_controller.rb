require 'instagram'

class HomeController < ApplicationController
  def index
    client = Instagram.client(:access_token => ENV['INSTAGRAM_CLIENT_TOKEN'])
    @grams = [] 
    results = Geocoder.search(Rails.env.production? ? request.remote_ip : "72.227.131.103")
    for media_item in client.media_search(results[0].latitude, results[0].longitude)
      @grams.push({image: media_item.images.low_resolution.url, tags: media_item.caption ? media_item.caption.text : media_item.tags.join(" #")})
    end
  end

  def search
  end

  def post
  end
end
