describe Skill do
  it "belongs to user" do
    new_user = Fabricate(:user)
    ruby = Skill.create(name: 'ruby', user: new_user)
    expect(ruby.user).to eq(new_user)
  end

  it "has many entries" do
    ruby = Skill.create(name: 'ruby', user: Fabricate(:user))
    new_entry = Fabricate(:entry, skill: ruby)
    new_entry_2 = Fabricate(:entry, skill: ruby)
    expect(ruby.entries.count).to eq(2)
  end

  it "has many rows" do
    ruby = Skill.create(name: 'ruby', user: Fabricate(:user))
    new_row = Fabricate(:row, skill: ruby)
    new_row_2 = Fabricate(:row, skill: ruby)
    expect(ruby.rows.count).to eq(2)
  end

  it "does not save a without a user" do
    ruby = Skill.create(name: 'ruby')
    expect(Skill.count).to eq(0)
  end

  it "does not save a without a name" do
    ruby = Skill.create(user: Fabricate(:user))
    expect(Skill.count).to eq(0)
  end

  it "can't have a duplicate name for a single user" do
    user1 = Fabricate(:user)
    ruby1 = Skill.create(name: 'ruby', user: user1)
    ruby2 = Skill.create(name: 'ruby', user: user1)
    expect(user1.skills.count).to eq(1)
  end

  it "can have duplicate names if they are for different users" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    ruby1 = Skill.create(name: 'ruby', user: user1)
    ruby2 = Skill.create(name: 'ruby', user: user2)
    expect(user1.skills.count).to eq(1)
    expect(user2.skills.count).to eq(1)
  end
end
