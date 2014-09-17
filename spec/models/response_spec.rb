require 'rails_helper'

RSpec.describe Response, :type => :model do

  it "notifies its existance", :no_database_cleaner => true do
    resp = Response.new(user_id: 99, question_id: 33, :content => { :answer => 'Hogwash' })
    expect { resp.notify }.to notify('new_responses', resp.to_json)
  end
end
