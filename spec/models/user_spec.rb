describe User do
  it "has many categories" do
    new_user = Fabricate(:user)
    cat1 = Fabricate(:category, user: new_user)
    cat2 = Fabricate(:category, user: new_user)
    expect(new_user.categories.count).to eq(2)
  end

  it "has many skills" do
    new_user = Fabricate(:user)
    skill1 = Fabricate(:skill, user: new_user)
    skill2 = Fabricate(:skill, user: new_user)
    expect(new_user.skills.count).to eq(2)
  end

  it "has many descriptions" do
    new_user = Fabricate(:user)
    desc1 = Fabricate(:description, user: new_user)
    desc2 = Fabricate(:description, user: new_user)
    expect(new_user.descriptions.count).to eq(2)
  end

  it "has many entries" do
    new_user = Fabricate(:user)
    entry1 = Fabricate(:entry, user: new_user)
    entry2 = Fabricate(:entry, user: new_user)
    expect(new_user.entries.count).to eq(2)
  end

  it "has many spreadsheets" do
    new_user = Fabricate(:user)
    spreadsheet1 = Fabricate(:spreadsheet, user: new_user)
    spreadsheet2 = Fabricate(:spreadsheet, user: new_user)
    expect(new_user.spreadsheets.count).to eq(2)
  end

  it "won't save without a username" do
    new_user = Fabricate.build(:user, username: nil)
    new_user.save
    expect(User.count).to eq(0)
  end

  it "won't save without a password" do
    new_user = Fabricate.build(:user, password: nil)
    new_user = User.create(password: 'password')
    expect(User.count).to eq(0)
  end
end
