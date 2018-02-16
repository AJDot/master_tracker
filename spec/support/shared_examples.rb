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
