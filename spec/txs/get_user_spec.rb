require 'rails_helper'

describe GetUserInfo do
  context 'if user is not in DB' do
    it 'returns the corresponding user object' do
      VCR.use_cassette('get_new_user_info_github') do
        params = {'nickname' => 'mindeavor'}
        user = GetUserInfo.run(params)
        expect(user.name).to eq("Gilbert")
        expect(user.uid).to eq("17013")
      end
    end
  end

  context 'if user is already in DB' do
    it 'returns the corresponding user object' do
      User.create(nickname: 'mindeavor', name: "Gilbert G.", uid: 1, verified: true, )
      params = {'nickname' => 'mindeavor'}
      user = GetUserInfo.run(params)
      expect(user.name).to eq("Gilbert G.")
      expect(user.uid).to eq("1")
    end
  end
end
