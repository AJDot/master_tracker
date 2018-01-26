Fabricator(:row) do
  spreadsheet { Fabricate(:spreadsheet) }
  category { Fabricate(:category) }
  skill { Fabricate(:skill) }
  description { Fabricate(:description) }
end
