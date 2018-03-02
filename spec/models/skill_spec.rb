describe Skill do
  it_behaves_like "it is an entry trait model" do
    let(:new_user) { Fabricate(:user) }
    let(:trait) { Skill.create(name: 'Ruby', user: new_user) }
  end
end
