ENV["RAILS_ENV"] ||= 'test'
require 'rubygems'
require 'vcr'
require 'webmock'
require 'pry-byebug'
require_relative 'support/request_spec_helper.rb'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end 

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end





