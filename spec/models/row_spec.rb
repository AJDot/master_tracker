describe Row do
  it "belongs to category" do
    category = Fabricate(:category)
    row = Fabricate(:row, category: category)
    expect(row.category).to eq(category)
  end

  it "belongs to skill" do
    skill = Fabricate(:skill)
    row = Fabricate(:row, skill: skill)
    expect(row.skill).to eq(skill)
  end

  it "belongs to description" do
    description = Fabricate(:description)
    row = Fabricate(:row, description: description)
    expect(row.description).to eq(description)
  end

  it "belongs to spreadsheet" do
    spreadsheet = Fabricate(:spreadsheet)
    row = Fabricate(:row, spreadsheet: spreadsheet)
    expect(row.spreadsheet).to eq(spreadsheet)
  end
end
