class History
  include ActionView::Helpers::DateHelper
  include Mongoid::Document
  include Mongoid::Timestamps

  field :taken_at, type: Time
  field :returned_at, type: Time

  belongs_to :user
  belongs_to :book

  validates :taken_at, presence: true
end
