Fabricator(:description) do
  name { Faker::Lorem::words(1) }
  user { Fabricate(:user) }
end
