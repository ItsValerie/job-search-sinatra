require 'sinatra'
require 'mongoid'
require 'nokogiri'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# ENDPOINTS

# root
get '/' do
  "Welcome!"
end

# index
get '/jobs' do
  Job.all
end

#search API
get "/jobs/search=#{keyword}" do
  get_api_response(keyword)
end

# API requests

