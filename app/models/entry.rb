class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :skill
  belongs_to :description
end
