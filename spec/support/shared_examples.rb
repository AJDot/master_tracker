shared_examples "user must own the page" do
  it "redirects to the user's profile page if user does not own page" do
    action
    expect(response).to redirect_to user_path(current_user)
  end

  it "sets the flash danger message if user does not own page" do
    action
    expect(flash[:danger]).to be_present
  end
end

shared_examples "requires sign in" do
  it "redirects to login path" do
    action
    expect(response).to redirect_to login_path
  end

  it "sets the flash danger message" do
    action
    expect(flash[:danger]).to be_present
  end
end

shared_examples "it is an entry trait model" do
  it "belongs to user" do
    expect(trait.user).to eq(new_user)
  end

  it "has many entries" do
    trait_key = described_class.to_s.downcase.to_sym
    new_entry = Fabricate(:entry, trait_key => trait)
    new_entry_2 = Fabricate(:entry, trait_key => trait)
    expect(trait.entries.count).to eq(2)
  end

  it "has many rows" do
    trait_key = described_class.to_s.downcase.to_sym
    new_row = Fabricate(:row, trait_key => trait)
    new_row_2 = Fabricate(:row, trait_key => trait)
    expect(trait.rows.count).to eq(2)
  end

  it 'generates a random token before creation' do
    trait
    expect(described_class.first.token).to be_present
  end

  it "does not save a without a user" do
    expect(described_class.count).to eq(0)
  end

  it "does not save a without a name" do
    described_class.create(name: "", user: new_user)
    expect(described_class.count).to eq(0)
  end

  it "can't have a duplicate name for a single user" do
    trait_dup = described_class.create(name: trait.name, user: new_user)
    method = described_class.to_s.downcase.pluralize.to_sym
    expect(new_user.send(method).count).to eq(1)
  end

  it "can have duplicate names if they are for different users" do
    user2 = Fabricate(:user)
    trait2 = described_class.create(name: trait.name, user: user2)
    method = described_class.to_s.downcase.pluralize.to_sym
    expect(new_user.send(method).count).to eq(1)
    expect(user2.send(method).count).to eq(1)
  end
end
