class CreateUnregisteredUser
  def self.run(params)

      user = User.new
      user.nickname = params['nickname']
      user.save

      return user
  end

end