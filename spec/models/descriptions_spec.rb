describe Description do
  it "belongs to user" do
    new_user = Fabricate(:user)
    ruby = Description.create(name: 'ruby', user: new_user)
    expect(ruby.user).to eq(new_user)
  end

  it "has many entries" do
    ruby = Description.create(name: 'ruby', user: Fabricate(:user))
    new_entry = Fabricate(:entry, description: ruby)
    new_entry_2 = Fabricate(:entry, description: ruby)
    expect(ruby.entries.count).to eq(2)
  end

  it "has many rows" do
    ruby = Description.create(name: 'ruby', user: Fabricate(:user))
    new_row = Fabricate(:row, description: ruby)
    new_row_2 = Fabricate(:row, description: ruby)
    expect(ruby.rows.count).to eq(2)
  end

  it "does not save a without a user" do
    ruby = Description.create(name: 'ruby')
    expect(Description.count).to eq(0)
  end

  it "does not save a without a name" do
    ruby = Description.create(user: Fabricate(:user))
    expect(Description.count).to eq(0)
  end

  it "can't have a duplicate name for a single user" do
    user1 = Fabricate(:user)
    ruby1 = Description.create(name: 'ruby', user: user1)
    ruby2 = Description.create(name: 'ruby', user: user1)
    expect(user1.descriptions.count).to eq(1)
  end

  it "can have duplicate names if they are for different users" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    ruby1 = Description.create(name: 'ruby', user: user1)
    ruby2 = Description.create(name: 'ruby', user: user2)
    expect(user1.descriptions.count).to eq(1)
    expect(user2.descriptions.count).to eq(1)
  end
end
