require 'sinatra'
require 'mongoid'
require 'nokogiri'
require 'json'
require 'active_support/core_ext/hash'

require_relative 'app/models/request_handler.rb'
require_relative 'app/models/job_query.rb'
require_relative 'app/models/job_opening.rb'

#DB setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# adding namespace?

# ENDPOINTS

# root
get '/' do
  "Welcome!"
end

# index
get '/jobs' do
  JobQuery.each do |query|
    parsed_query = JSON.parse(query.results)
    until parsed_query['rss']['channel']['item'].nil?
      position = parsed_query['rss']['channel']['item'].first['title']
      company = parsed_query['rss']['channel']['item'].first['author']['name']
      skills = parsed_query['rss']['channel']['item'].first['category']
      website = parsed_query['rss']['channel']['item'].first['link']
      summary = parsed_query['rss']['channel']['item'].first['description']
      p JobOpening.create!(position: position, company: company, skills: skills, website: website, summary: summary).to_json
    end
  end
  # convert to json again?
end

#handling request to Stackoverflow API
get '/jobs/:keyword' do
  keyword = params['keyword']
  json_string = search_and_retrieve_data(keyword)
  job_query = JobQuery.create!(results: json_string) unless ['totalResults'].zero?
  job_query.valid? ? p "Request successful" : p "No results for this request"
  "Query results: #{JSON.parse(json_string)}"
end

private

def search_and_retrieve_data(keyword)
  handler = RequestHandler.new(keyword)
  results_xml = handler.get_api_response(keyword)
  as_json(results_xml)
end
