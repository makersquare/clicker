require 'rails_helper'

describe GetUserInfo do
  context 'if user is not in DB' do
    it 'returns the corresponding user object' do
      VCR.use_cassette('get_new_user_info_github') do
        params = {'nickname' => 'mindeavor'}
        user = GetUserInfo.run(params)
        expect(user.name).to eq("Gilbert")
        expect(user.uid).to eq("17013")
        expect(user.gravatar_id).to eq("44d05cf62687c3489b863e4677414ca6")
      end
    end
  end

  context 'if user is already in DB' do
    it 'returns the corresponding user object' do
      User.create(nickname: 'mindeavor', name: "Gilbert G.", uid: 1, verified: true, gravatar_id: "asdfjkl;")
      params = {'nickname' => 'mindeavor'}
      user = GetUserInfo.run(params)
      expect(user.name).to eq("Gilbert G.")
      expect(user.uid).to eq("1")
      expect(user.gravatar_id).to eq("asdfjkl;")
    end
  end
end
