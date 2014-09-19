require 'rails_helper'

RSpec.describe Response, :type => :model do

  it "notifies its existence", :no_database_cleaner => true do
    resp = Response.new(user_id: 99, question_id: 33, :content => { :answer => 'Hogwash' })
    expect { resp.notify }.to notify('new_responses', resp.to_json)
  end

  describe "Response's content validation" do
    let (:model) do
      Fabricate(:response)
    end

    it "validates presence of question id" do
      model.question_id = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_question_id)
    end

    it "validates presence of response" do
      model.content["response"] = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_response)
    end

    it "validates presence of user id" do
      model.user_id = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_user_id)
    end
  end

end
