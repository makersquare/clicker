require 'rails_helper'

RSpec.describe "Postgres LISTEN / NOTIFY" do

  it "does stuff", :no_database_cleaner => true do
    pg = PGconn.open(:dbname => 'clicker_test')
    it_ran = false

    conn = ActiveRecord::Base.connection.raw_connection

    pg.exec "LISTEN my_channel"
    conn.exec "NOTIFY my_channel, 'hello'"
    pg.wait_for_notify(1) do |channel, pid, payload|
      it_ran = true
    end

    expect(it_ran).to eq true

  end

end
