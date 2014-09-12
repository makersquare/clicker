require 'net/http'
require 'json'

class UpdateUserInfo
  def self.run(params)
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
    return user
  end
end