require 'open-uri'
require 'nokogiri'
require_relative 'job_query.rb'

# responsible for making API GET request
class RequestHandler
  def get_api_response(keyword)
    url = "http://stackoverflow.com/jobs/feed?q=#{keyword}"
    xml = Nokogiri::XML(open(url)) do |config|
      config.strict.noblanks
    end
  end
end
