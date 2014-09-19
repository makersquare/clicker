require 'net/http'
require 'json'

class UpdateUserInfo
  def self.run(user)
    url = 'https://api.github.com/users/' + user.nickname
    uri = URI(url)
    data = Net::HTTP.get(uri)
    json = JSON.parse(data)

    user.name = json['name']
    user.uid = json['id'].to_s #typecast into string to match omniauth's format
    user.provider = 'github'
    user.gravatar_id = json['gravatar_id']

    if user.verified.nil?
      user.verified = false
    end

    if user.name.nil?
      user.name = user.nickname
    end

    user.save
    return user
  end

  def self.membership_run(user)
    url = 'https://api.github.com/users/' + user[:memberships][:nickname]
    uri = URI(url)
    data = Net::HTTP.get(uri)
    json = JSON.parse(data)

    user.name = json['name']
    user.uid = json['id'].to_s #typecast into string to match omniauth's format
    user.provider = 'github'
    user.gravatar_id = json['gravatar_id']

    if user.verified.nil?
      user.verified = false
    end

    if user.name.nil?
      user.name = user.nickname
    end

    user.save
    return user
  end
end
