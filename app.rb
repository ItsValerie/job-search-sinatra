require 'sinatra'
require 'mongoid'
require 'nokogiri'
require 'active_support/core_ext/hash'
require 'json'

require_relative 'app/models/request_handler.rb'
require_relative 'app/models/job_query.rb'
require_relative 'app/models/job_opening.rb'

#DB setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# adding namespace?

# ENDPOINTS

# root
get '/' do
  "Welcome! To make a request to the Stack Overflow's Job API add /yourkeyword to the url of this page"
end

# index
get '/jobs' do
  JobQuery.each do |query|
    parsed_query = JSON.parse(query.results)
    p parsed_query['rss']['xmlns:a10'] # this is returning something?
    # p JobOpening.new(title: parsed_query[:item][:title], company: parsed_query[:item][:author], link: parsed_query[:item][:link], skills: parsed_query[:item][:category])
  end

  # parse data here to get a nice output of all queries
  #
  # when you want to see the entire query then check your terminal output when running 'ruby app.rb'
end

#handling request to Stackoverflow API
# invoke controller action here
get '/jobs/:keyword' do
  # url = request.url
  keyword = params['keyword']
  handler = RequestHandler.new(keyword)
  results_xml = handler.get_api_response(keyword)
  json_string = Hash.from_xml(results_xml.to_s).to_json
  job_query = JobQuery.create!(results: json_string)
  puts "This worked" if job_query.valid?
  "Result: #{JSON.parse(json_string)}" # for testing purposes only
end
