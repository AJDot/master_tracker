Fabricator(:spreadsheet) do
  name { Faker::Lorem::words(2).join(" ")}
  user { Fabricate(:user) }
end
