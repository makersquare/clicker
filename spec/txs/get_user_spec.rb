require 'rails_helper'

describe GetUserInfo do

  context 'if user is already in DB' do
    before(:all) do
      User.create(nickname: 'mindeavor', name: "Gilbert", uid: 1, verified: true, )
    end

    it 'returns the corresponding user object' do
        params = {'nickname' => 'mindeavor'}
        user = GetUserInfo.run(params)
        expect(user.name).to eq("Gilbert")
        expect(user.uid).to eq("1")
    end
  end
end