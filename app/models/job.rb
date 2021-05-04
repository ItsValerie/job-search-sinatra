class Jobs
  include Mongoid::Document

  field :title, type: String
  field :company, type: String

end
