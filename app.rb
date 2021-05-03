require 'sinatra'
require 'mongoid'
require 'nokogiri'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# adding namespace?

# ENDPOINTS

# root
get '/' do
  "Welcome!"
end

# index
get '/jobs' do
  RequestHandler.list_all
end

#search API
get "/jobs/search=#{keyword}" do
  search_and_retrieve_data(keyword)
end

# API requests

