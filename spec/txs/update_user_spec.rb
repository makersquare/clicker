require 'rails_helper'

describe UpdateUserInfo do
  it "connects to GitHub API and pulls correct user info by nickname" do
    VCR.use_cassette('github_user_data') do
      new_user = User.new(nickname: 'makersquare')
      url = 'https://api.github.com/users/' + new_user.nickname
      uri = URI(url)
      data = Net::HTTP.get(uri)
      assert_match 'https://api.github.com/users/makersquare', data
    end
  end


  context 'when user has entered a profile name in github that name is used' do
    it "updates user data based on GitHub API" do
      VCR.use_cassette('user_data') do
        new_user = User.new(nickname: 'makersquare')
        user = UpdateUserInfo.run(new_user)
        expect(user.name).to eq 'MakerSquare'
        expect(user.uid).to eq "4218375"
        expect(user.nickname).to eq 'makersquare'
        expect(user.gravatar_id).to eq '687058c0dcf54250a1dfef3515bbc2a7'
      end
    end
  end

  context 'when user has NOT entered a profile name in github the nickname is used instead' do
    it "updates user data based on GitHub API" do
      VCR.use_cassette('user_data_without_name') do
        new_user = User.new(nickname: 'aacase')
        user = UpdateUserInfo.run(new_user)
        expect(user.name).to eq 'aacase'
        expect(user.uid).to eq "7494406"
        expect(user.nickname).to eq 'aacase'
        expect(user.gravatar_id).to eq 'c69be0666998b3529d1f562a6fd70e7e'
      end
    end
  end
end
