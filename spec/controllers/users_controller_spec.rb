describe UsersController do
  describe "GET show" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        get :show, params: { id: current_user.id }
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(current_user)
      end
    end

    context "with unauthenticated user" do
      it "redirects to login path" do
        get :show, params: { id: Fabricate(:user).id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET new" do
    it "sets @user to a new User" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        post :create, params: { user: Fabricate.attributes_for(:user) }
      end

      it "creates a user" do
        expect(User.count).to eq(1)
      end

      it "signs in the user" do
        expect(session[:user_id]).not_to be_nil
      end

      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to the user show page" do
        expect(response).to redirect_to user_path(assigns(:user))
      end
    end

    context "with invalid inputs" do
      before do
        post :create, params: { user: Fabricate.attributes_for(:user, username: "") }
      end

      it "does not create a user" do
        expect(User.count).to eq(0)
      end

      it "sets @user" do
        expect(assigns(:user)).to be_new_record
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        get :edit, params: { id: current_user.id }
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(current_user)
      end
    end

    context "with unauthenticated user" do
      it "redirects to login path" do
        get :edit, params: { id: Fabricate(:user).id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "PATCH update" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user, username: "old_name") }
      before do
        session[:user_id] = current_user.id
      end

      context "with valid inputs" do
        before do
          patch :update, params: { user: { username: "new_name" }, id: current_user.id }
        end

        it "updates the signed in user" do
          expect(User.first.username).to eq("new_name")
        end

        it "sets the flash success messsage" do
          expect(flash[:success]).not_to be_blank
        end

        it "redirects to the signed in user show page" do
          expect(response).to redirect_to user_path(current_user)
        end
      end

      context "with invalid inputs" do
        before do
          patch :update, params: { user: { username: "" }, id: current_user.id }
        end

        it "does not update the user" do
          expect(User.first.username).to eq("old_name")
        end

        it "sets @user" do
          expect(assigns(:user)).to eq(current_user)
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end
      end
    end

    context "with unauthenticated user" do
      it "redirects to login path" do
        patch :update, params: { user: Fabricate.attributes_for(:user), id: Fabricate(:user).id }
        expect(response).to redirect_to login_path
      end
    end
  end
end
