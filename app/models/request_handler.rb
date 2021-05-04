# Job model as database handler
require 'open-uri'
require 'nokogiri'
require_relative 'job.rb'
# require 'xml/to/json'

class RequestHandler

  def initialize(keyword)
    @keyword = keyword
  end

  def get_api_response(keyword)
    url = "http://stackoverflow.com/jobs/feed?q=#{keyword}"
    xml = Nokogiri::XML(open(url))
  end

  # def prepare_response
  #   begin
  #     JSON.parse(request.body.read)
  #   rescue
  #     halt 400, { message: 'Invalid JSON' }.to_json
  #   end
  # end



end

# test
# xml = get_api_response('backenddeveloper')
# p to_json(xml)

