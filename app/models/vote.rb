class Vote
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :category, type: String
  field :name, type: String
  field :remote_ip, type: String
  field :user_agent, type: String
  validates :category, presence: true
  validates :name, presence: true

  index category: 1
  index created_at: 1
  index name: 1

  def suspicious?
    last_one = Vote.last_one(self.category)
    return false unless last_one
    if last_one.name == self.name &&
        last_one.remote_ip == self.remote_ip &&
        last_one.user_agent == self.user_agent &&
        ((self.created_at || Time.now) - last_one.created_at) < Voteapi::VOTE_SPAN
      return true
    end
    false
  end

  class << self
    def category(category)
      where(category: category)
    end

    def last_one(category = nil)
      if category.present?
        criteria = category(category)
      else
        criteria = self
      end
      criteria.desc(:created_at).first
    end

    def of_name(name)
      where(name: name)
    end
  end
end
