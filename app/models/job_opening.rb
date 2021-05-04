class JobOpening
  include Mongoid::Document

  field :position, type: String
  field :company, type: String
  field :website, type: String
  field :skills, type: String
  field :summary, type: String
end

# JSON resume data model
# "work": [{
#     "company": "Company",
#     "position": "President",
#     "website": "http://company.com",
#     "startDate": "2013-01-01",
#     "endDate": "2014-01-01",
#     "summary": "Description...",
#     "highlights": [
#       "Started the company"
#     ]
