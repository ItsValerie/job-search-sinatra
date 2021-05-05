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

# adding namespace?

# ENDPOINTS

# root
get '/' do
  "Welcome!"
end

# index - GET request to DB
get '/jobs' do
  JobQuery.each do |query|
    parsed_query = JSON.parse(query.results)
    jobs = parsed_query['rss']['channel']['item']
    until jobs.nil? do
      jobs.each do |job|
        position = job['title']
        company = job['author']['name']
        skills = job['category']
        website = job['link']
        summary = job['description']
        saved_job_opening = build_job_opening(position, company, skills, website, summary)
        p "Successful" unless saved_job_opening.nil?# testing purposes only
        # "#{saved_job_opening}"
      end
    end
  end
  #   until parsed_query['rss']['channel']['item'].nil? do
  #     position = parsed_query['rss']['channel']['item'].first['title']
  #     company = parsed_query['rss']['channel']['item'].first['author']['name']
  #     skills = parsed_query['rss']['channel']['item'].first['category']
  #     website = parsed_query['rss']['channel']['item'].first['link']
  #     summary = parsed_query['rss']['channel']['item'].first['description']
  #     "#{build_job_opening(position, company, skills, website, summary)}"
  #   end
  # end
  # convert to json again?
  # print result in browser
end

#GET request to Stackoverflow API
get '/jobs/:keyword' do
  keyword = params['keyword']
  handler = RequestHandler.new(keyword)
  results_xml = handler.get_api_response(keyword)
  json_string = Hash.from_xml(results_xml.to_s).to_json
  parsed_query = JSON.parse(json_string)
  job_query = JobQuery.create!(results: json_string) unless parsed_query['rss']['channel']['totalResults'].to_i.zero?
  job_query.nil? ? "No results for this request" : "#{json_string}"
end

private

def build_job_opening(position, company, skills, website, summary)
  JobOpening.create!(position: position, company: company, skills: skills, website: website, summary: summary)#.to_json
end
