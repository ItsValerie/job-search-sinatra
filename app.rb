require 'sinatra'
require 'sinatra/json'
require 'mongoid'
require 'nokogiri'
require 'active_support/core_ext/hash'
require 'crack'
require 'json'
require_relative 'app/models/request_handler.rb'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# adding namespace?

# ENDPOINTS

# root
get '/' do
  "Welcome! To search for jobs add this to the url: /yourkeyword"
end

# index
get '/jobs' do
  RequestHandler.list_all
end

#handling request to Stackoverflow API
get '/jobs/:keyword' do
  # "URL = #{request.url}"
  url = request.url
  keyword = params['keyword']
  handler = RequestHandler.new(keyword)
  results_xml = handler.get_api_response(keyword)
  results_json = Hash.from_xml(results_xml.to_s).to_json
  "#{results_json}"
  # p results_json
  # p results_json
  # results_json = Crack::XML.parse(ml)
  # p results_json
  # "This is the result #{results_json}"


end

# API requests

