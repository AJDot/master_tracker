describe Category do
  it "belongs to user" do
    new_user = Fabricate(:user)
    ruby = Category.create(name: 'ruby', user: new_user)
    expect(ruby.user).to eq(new_user)
  end

  it "has many entries" do
    ruby = Category.create(name: 'ruby', user: Fabricate(:user))
    new_entry = Fabricate(:entry, category: ruby)
    new_entry_2 = Fabricate(:entry, category: ruby)
    expect(ruby.entries.count).to eq(2)
  end

  it "has many rows" do
    ruby = Category.create(name: 'ruby', user: Fabricate(:user))
    new_row = Fabricate(:row, category: ruby)
    new_row_2 = Fabricate(:row, category: ruby)
    expect(ruby.rows.count).to eq(2)
  end

  it "does not save a without a user" do
    ruby = Category.create(name: 'ruby')
    expect(Category.count).to eq(0)
  end

  it "does not save a without a name" do
    ruby = Category.create(user: Fabricate(:user))
    expect(Category.count).to eq(0)
  end

  it "can't have a duplicate name for a single user" do
    user1 = Fabricate(:user)
    ruby1 = Category.create(name: 'ruby', user: user1)
    ruby2 = Category.create(name: 'ruby', user: user1)
    expect(user1.categories.count).to eq(1)
  end

  it "can have duplicate names if they are for different users" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    ruby1 = Category.create(name: 'ruby', user: user1)
    ruby2 = Category.create(name: 'ruby', user: user2)
    expect(user1.categories.count).to eq(1)
    expect(user2.categories.count).to eq(1)
  end
end
