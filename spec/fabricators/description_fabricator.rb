Fabricator(:description) do
  name { Faker::Lorem.unique.words(1) }
  user { Fabricate(:user) }
end
