class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  field :username, type: String
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time

  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end
