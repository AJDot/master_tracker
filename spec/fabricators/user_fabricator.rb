Fabricator(:user) do
  username { Faker::Name.unique.name.gsub(" ", "") }
  password { Faker::Lorem.characters(10)}
end
