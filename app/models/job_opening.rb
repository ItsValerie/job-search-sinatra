class JobOpening
  include Mongoid::Document

  field :title, type: String
  field :company, type: String
  field :link, type: String
  field :skills, type: String
end
