
class GetUserInfo
  def self.run(params)
      user = User.find_by(nickname: params['nickname']) 
      
      if user.nil?
        user = User.new(nickname: params['nickname'])
        user = UpdateUserInfo.run(user)
      end

      return user
  end
end