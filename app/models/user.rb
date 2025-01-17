class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String

  has_many :comments
  has_many :histories
end
