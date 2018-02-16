class Category < ActiveRecord::Base
  include Tokenable

  has_many :entries

  belongs_to :user

  has_many :rows

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false}
  validates :user, presence: true

  before_create :generate_token

  def to_param
    token
  end
end
