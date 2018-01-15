class Category < ActiveRecord::Base
  has_many :entries
  has_many :category_skills
  has_many :skills, through: :category_skills
  has_many :category_descriptions
  has_many :descriptions, through: :category_descriptions
end
