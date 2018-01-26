Fabricator(:entry) do
  duration { Faker::Number.between(1, 500) }
  date { Faker::Time.between(2.days.ago, Date.today) }
  user { Fabricate(:user) }
  category { Fabricate(:category) }
  skill { Fabricate(:skill) }
  description { Fabricate(:description) }
end
