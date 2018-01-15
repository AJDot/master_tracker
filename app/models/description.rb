class Description < ActiveRecord::Base
  has_many :entries
  has_many :description_skills
  has_many :skills, through: :description_skills
  has_many :category_descriptions
  has_many :categories, through: :category_descriptions
end
