require 'sinatra'
require 'mongoid'
require 'nokogiri'
require 'json'
require 'active_support/core_ext/hash'

require_relative 'app/models/request_handler'
require_relative 'app/models/job_query'
require_relative 'app/models/job_opening'

#DB setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# ENDPOINTS

# root
get '/' do
  "Welcome!"
end

# index - GET request to DB (returns JSON string of last job query saved)
get '/jobs' do
  last_job_query = JobQuery.last.results
  ERB.new("#{last_job_query}").result
end

# index - GET request to DB (not working yet)
# get '/jobs' do
#   JobQuery.each do |query|
#     parsed_query = JSON.parse(query.results)
#     job_openings = parsed_query['rss']['channel']['item']
#     unless job_openings.nil? do
#       job_openings.each do |job|
#         position = job['title']
#         company = job['author']['name']
#         skills = job['category']
#         website = job['link']
#         summary = job['description']
#         build_job_opening(position, company, skills, website, summary)
#       end
#     end
#   end
# end

# GET request to Stackoverflow API
get '/jobs/:keyword' do
  keyword = params['keyword']
  handler = RequestHandler.new
  xml_results = handler.get_api_response(keyword)
  json_string = Hash.from_xml(xml_results.to_s).to_json
  parsed_query = JSON.parse(json_string)
  job_query = JobQuery.create!(results: json_string) unless parsed_query['rss']['channel']['totalResults'].to_i.zero?
  job_query.nil? ? "No results for this request" : "#{json_string}"
end

private

def build_job_opening(position, company, skills, website, summary)
  JobOpening.create!(position: position, company: company, skills: skills, website: website, summary: summary)
end
