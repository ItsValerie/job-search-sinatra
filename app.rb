require 'sinatra'
require 'mongoid'
require 'nokogiri'
require 'active_support/core_ext/hash'
require 'json'

require_relative 'app/models/request_handler.rb'
require_relative 'app/models/job_query.rb'

#DB setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# adding namespace?

# ENDPOINTS

# root
get '/' do
  "Welcome! To search for jobs add this to the url: /yourkeyword"
end

# index
get '/jobs' do
  job_queries = JobQuery.all

  [:request].each do |query|
    jobs = job_queries.send(query, params[query]) if params[query]
  end
  p job_queries
end

#handling request to Stackoverflow API
# invoke controller action here
get '/jobs/:keyword' do
  url = request.url
  keyword = params['keyword']
  handler = RequestHandler.new(keyword)

  results_xml = handler.get_api_response(keyword)
  json_string = Hash.from_xml(results_xml.to_s).to_json
  job_query = JobQuery.create!(results: json_string)
  puts "This worked" if job_query.valid?
  "Result: #{job.class}"

end

