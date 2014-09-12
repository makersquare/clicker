
class GetUserInfo
  def self.run(params)
      user = User.find_by(nickname: params['nickname']) 
      
      if user.nil?
        user = UpdateUserInfo.run(params)
      end

      return user
  end
end