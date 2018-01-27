describe DescriptionsController, type: :controller do
  describe "GET new" do
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        get :new, params: { user_id: current_user.id }
      end

      it "sets @description" do
        expect(assigns(:description)).to be_new_record
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(current_user)
      end
    end

    context "with unauthenticate users" do
      it "redirects to login path" do
        get :new, params: { user_id: Fabricate(:user).id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end

      context "with valid inputs" do
        before do
          post :create, params: { description: { name: "new_description" }, user_id: current_user.id }
        end

        it "redirects to the user show page" do
          expect(response).to redirect_to user_path(current_user)
        end

        it "creates a description" do
          expect(Description.count).to eq(1)
        end

        it "create a description associated with the signed in user" do
          expect(Description.first.user).to eq(current_user)
        end
      end

      context "with invalid inputs" do
        before do
          post :create, params: { description: { name: "" }, user_id: current_user.id }
        end

        it "does not create a description" do
          expect(Description.count).to eq(0)
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end

        it "sets @description" do
          expect(assigns(:description).name).to eq("")
        end
      end
    end

    context "with unauthenticated users" do
      before do
        post :create, params: { description: { name: "new_description" }, user_id: 1 }
      end

      it "redirects to the login path" do
        expect(response).to redirect_to login_path
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET edit" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      let(:description) { Fabricate(:description, user: current_user) }
      before do
        session[:user_id] = current_user.id
        get :edit, params: { id: description.id, user_id: current_user.id}
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(current_user)
      end

      it "sets @description" do
        expect(assigns(:description)).to eq(description)
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:description) { Fabricate(:description, user: user) }
      before do
        get :edit, params: { id: description.id, user_id: user.id }
      end

      it "redirects to the login path" do
        expect(response).to redirect_to login_path
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "PATCH update" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      let(:description) { Fabricate(:description, user: current_user, name: "old_name") }
      before do
        session[:user_id] = current_user.id
      end

      context "with valid inputs" do
        before do
          patch :update, params: { description: { name: "new_name" }, user_id: current_user.id, id: description.id }
        end

        it "redirects to the user show page" do
          expect(response).to redirect_to user_path(current_user)
        end

        it "updates a description" do
          expect(Description.first.name).to eq("new_name")
        end

        it "sets the flash success message" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid inputs" do
        let(:description) { Fabricate(:description, name: "old_name", user: current_user) }
        before do
          post :update, params: { description: { name: "" }, user_id: current_user.id, id: description.id }
        end

        it "does not update a description" do
          expect(description.name).to eq('old_name')
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

        it "sets @description" do
          expect(assigns(:description)).to eq(description)
        end
      end
    end

    context "with unauthenticated user" do
      before do
        user = Fabricate(:user)
        description = Fabricate(:description, name: "old_name", user: user)
        post :update, params: { description: { name: nil }, user_id: user.id, id: description.id }
      end

      it "redirects to the login path" do
        expect(response).to redirect_to login_path
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end
end
