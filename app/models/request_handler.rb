# Job model as database handler
require 'open-uri'
require 'nokogiri'
# require 'xml/to/json'

class RequestHandler

  def initialize(keyword)
    @keyword = keyword
  end

  def get_api_response(keyword)
    url = "http://stackoverflow.com/jobs/feed?q=#{keyword}"
    xml = Nokogiri::XML(open(url))
  end

  # def to_json(xml)
  #   JSON.pretty_generate(xml)
  # end

  def save_to_db(json)
    # create new instances
    # save to MongoDB
  end

  def self.list_all
    # list all data from mongodb as json
  end
end

# test
# xml = get_api_response('backenddeveloper')
# p to_json(xml)

