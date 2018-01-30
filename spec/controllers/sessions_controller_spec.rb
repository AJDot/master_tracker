describe SessionsController do
  describe "GET new" do
    it "renders the :new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to user profile for authenticated users" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to user_path(user)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      let(:alice) { Fabricate(:user, username: "Alex", password: 'password') }
      before do
        post :create, params: { username: alice.username, password: alice.password }
      end

      it "sets the user_id in the session" do
        expect(session[:user_id]).to eq(alice.id)
      end

      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to the user profile page" do
        expect(response).to redirect_to user_path(alice)
      end
    end

    context "with invalid inputs" do
      before do
        post :create, params: { username: "nothing", password: "nopassword" }
      end

      it "redirects to the login path" do
        expect(response).to redirect_to login_path
      end

      it "sets flash danger message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "DELETE destroy" do
    let(:current_user) { Fabricate(:user) }
    before do
      session[:user_id] = current_user.id
      delete :destroy
    end

    it "signs out the current user" do
      expect(session[:user_id]).to be_nil
    end

    it "sets the flash success message" do
      expect(flash[:success]).not_to be_blank
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end
