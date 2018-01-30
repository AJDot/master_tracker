describe WelcomeController do
  describe "GET index" do
    it "redirects to user profile for authenticated user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      get :index
      expect(response).to redirect_to user_path(alice)
    end

    it "renders the index template for unauthenticated users" do
      get :index
      expect(response).to render_template :index
    end
  end
end
