describe Entry do
  it "belongs to user" do
    new_user = Fabricate(:user)
    new_entry = Fabricate(:entry, user: new_user)
    expect(new_entry.user).to eq(new_user)
  end

  it "belongs to category" do
    new_cat = Fabricate(:category)
    new_entry = Fabricate(:entry, category: new_cat)
    expect(new_entry.category).to eq(new_cat)
  end

  it "belongs to skill" do
    new_skill = Fabricate(:skill)
    new_entry = Fabricate(:entry, skill: new_skill)
    expect(new_entry.skill).to eq(new_skill)
  end

  it "belongs to description" do
    new_desc = Fabricate(:description)
    new_entry = Fabricate(:entry, description: new_desc)
    expect(new_entry.description).to eq(new_desc)
  end

  it "won't save without a category" do
    new_entry = Fabricate.build(:entry, category: nil)
    new_entry.save
    expect(Entry.count).to eq(0)
  end

  it "won't save without a skill" do
    new_entry = Fabricate.build(:entry, skill: nil)
    new_entry.save
    expect(Entry.count).to eq(0)
  end

  it "won't save without a description" do
    new_entry = Fabricate.build(:entry, description: nil)
    new_entry.save
    expect(Entry.count).to eq(0)
  end

  it "won't save without a date" do
    new_entry = Fabricate.build(:entry, date: nil)
    new_entry.save
    expect(Entry.count).to eq(0)
  end

  it "won't save without a duration" do
    new_entry = Fabricate.build(:entry, duration: nil)
    new_entry.save
    expect(Entry.count).to eq(0)
  end

  it "won't save if duration is not a number" do
    new_entry = Fabricate.build(:entry, duration: 'APPLE')
    new_entry.save
    expect(Entry.count).to eq(0)
  end

  it "won't save if duration is a decimal" do
    new_entry = Fabricate.build(:entry, duration: 1.1)
    new_entry.save
    expect(Entry.count).to eq(0)
  end

  it "won't save if duration is 0 or less" do
    new_entry = Fabricate.build(:entry, duration: 0)
    new_entry.save
    new_entry2 = Fabricate.build(:entry, duration: -10)
    new_entry2.save
    expect(Entry.count).to eq(0)
  end
end
