class RequestController
  include Mongoid::Document

  def initialize(params)
    @url = params[:url]
  end

  handler = RequestHandler.new(url)

  def search_and_retrieve_data(keyword)
    # passing in a keyword
    # calling api with keyword
    xml = handler.get_api_response(keyword)
    # parsing to json
    json = handler.to_json(xml)
     # returning json result
    # saving to DB
    handler.save_jobs(save)
  end


end
