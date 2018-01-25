class Spreadsheet < ActiveRecord::Base
  belongs_to :user
  has_many :rows

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def create_date
    created_at.strftime('%b %e, %Y')
  end

  def create_time
    created_at.strftime('%l:%M %p')
  end

  def update_date
    updated_at.strftime('%b %e, %Y')
  end

  def update_time
    updated_at.strftime('%l:%M %p')
  end
end
