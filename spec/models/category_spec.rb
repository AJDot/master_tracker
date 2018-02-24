describe Category do
  it_behaves_like "it is an entry trait model" do
    let(:new_user) { Fabricate(:user) }
    let(:trait) { Category.create(name: 'Software Development', user: new_user) }
  end
end
