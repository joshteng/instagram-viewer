class InstagramUser
  ACCESSTOKEN = ENV["INSTAGRAM_ACCESS_TOKEN"]
  PROPERTIES = [:id, :username]



  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(hash = {})
    hash.each do |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    end
  end

  def self.search(handler, &block)
    BW::HTTP.get("https://api.instagram.com/v1/users/search?q=#{handler}&access_token=#{ACCESSTOKEN}") do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      result_data = result_data['data']
      users = []

      result_data.each do |user|
        user_data = user.keep_if { |key,value| key == 'username' || key == 'id' }
        users << InstagramUser.new(user_data)
      end
  
      block.call(users)
    end
  end


  def get_media(&block)
    BW::HTTP.get("https://api.instagram.com/v1/users/#{self.id}/media/recent/?access_token=#{ACCESSTOKEN}") do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      result_data = result_data['data']
      
      recent_media = []
      result_data.each do |media|
        media_hash = { "image_link" => media['images']['low_resolution']['url'], "likes_count" => media['likes']['count'] }
        recent_media << Media.new(media_hash)
      end

      block.call(recent_media)
    end
  end

end