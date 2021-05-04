require 'active_support/core_ext/hash'
require 'json'

class JobQuery
  include Mongoid::Document

  field :results, type: String

  def as_json(xml)
    Hash.from_xml(xml.to_s).to_json
  end
end
