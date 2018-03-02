describe Description do
  it_behaves_like "it is an entry trait model" do
    let(:new_user) { Fabricate(:user) }
    let(:trait) { Description.create(name: 'Mastery Tracker', user: new_user) }
  end
end
