Fabricator(:user) do
  username { Faker::Name.unique.first_name }
  password { Faker::Lorem.characters(10)}
end
