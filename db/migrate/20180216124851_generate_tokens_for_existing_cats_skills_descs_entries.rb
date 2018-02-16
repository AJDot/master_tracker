class GenerateTokensForExistingCatsSkillsDescsEntries < ActiveRecord::Migration[5.1]
  def change
    Category.all.each do |category|
      category.token = SecureRandom.urlsafe_base64
      category.save
    end
    Skill.all.each do |skill|
      skill.token = SecureRandom.urlsafe_base64
      skill.save
    end
    Description.all.each do |description|
      description.token = SecureRandom.urlsafe_base64
      description.save
    end
    Entry.all.each do |entry|
      entry.token = SecureRandom.urlsafe_base64
      entry.save
    end
  end
end
