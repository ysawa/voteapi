class Vote
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :category, type: String
  field :name, type: String

  index category: 1
  index created_at: 1
  index name: 1
end
