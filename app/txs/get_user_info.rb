require 'net/http'
require 'json'

class GetUserInfo
  def self.run(params)
      user = User.find_by(nickname: params['nickname']) 
      
      if user.nil?
        url = 'https://api.github.com/users/' + params["nickname"]
        uri = URI(url)
        data = Net::HTTP.get(uri)
        json = JSON.parse(data)

        user = User.new
        user.nickname = params['nickname']
        user.name = json['name']
        user.uid = json['id']
        user.provider = 'github'
        user.verified = false
        
        if user.name.nil?
          user.name = params['nickname']
        end

        user.save
      end

      return user
  end

end