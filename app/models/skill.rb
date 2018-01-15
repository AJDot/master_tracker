class Skill < ActiveRecord::Base
  has_many :entries
  has_many :description_skills
  has_many :descriptions, through: :description_skills
  has_many :category_skills
  has_many :categories, through: :category_skills
end
