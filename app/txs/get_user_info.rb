
class GetUserInfo
  def self.run(params)
      user = User.find_by(nickname: params['nickname'])

      if user.nil?
        user = User.new(nickname: params['nickname'])
        user = UpdateUserInfo.run(user)
      end

      return user
  end

  def self.membership_check(params)
    user = User.find_by(nickname: params[:membership][:nickname])

    if user.nil?
      user = User.new(nickname: params[:membership][:nickname])
      user = UpdateUserInfo.membership_run(user)
  end
end
