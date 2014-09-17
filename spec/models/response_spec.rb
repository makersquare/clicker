require 'rails_helper'

RSpec.describe Response, :type => :model do

  it "notifies its existance", :no_database_cleaner => true do
    pg = PGconn.open(:dbname => 'clicker_test')
    pg.exec "LISTEN new_responses"

    resp = Response.new(user_id: 99, question_id: 33, :content => { :answer => 'Hogwash' })
    resp.notify

    notified = false
    pg.wait_for_notify(1) do |channel, pid, payload|
      notified = true
      expect(channel).to eq 'new_responses'
      expect(payload).to eq resp.to_json
    end
    expect(notified).to eq true
  end
end
