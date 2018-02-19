describe CategoriesController, type: :controller do
  describe "GET new" do
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          get :new, params: { user_id: current_user.username + 'a' }
        end
      end

      it "sets @category" do
        get :new, params: { user_id: current_user.username }
        expect(assigns(:category)).to be_new_record
        expect(assigns(:category)).to be_instance_of(Category)
      end

      it "sets @user" do
        get :new, params: { user_id: current_user.username }
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

      it_behaves_like "user must own the page" do
        let(:action) do
          post :create, params: { category: { name: "new_category" }, user_id: current_user.username + 'a' }
        end
      end

      context "with valid inputs" do
        before do
          post :create, params: { category: { name: "new_category" }, user_id: current_user.username }
        end

        it "redirects to the user show page" do
          expect(response).to redirect_to user_path(current_user)
        end

        it "creates a category" do
          expect(Category.count).to eq(1)
        end

        it "create a category associated with the signed in user" do
          expect(Category.first.user).to eq(current_user)
        end
      end

      context "with invalid inputs" do
        before do
          post :create, params: { category: { name: "" }, user_id: current_user.username }
        end

        it "does not create a category" do
          expect(Category.count).to eq(0)
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end

        it "sets @category" do
          expect(assigns(:category)).to be_new_record
          expect(assigns(:category).name).to eq("")
        end
      end
    end

    context "with unauthenticated users" do
      before do
        post :create, params: { category: { name: "new_category" }, user_id: 1 }
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
      let(:category) { Fabricate(:category, user: current_user) }
      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          get :edit, params: { id: category.token, user_id: current_user.username + 'a' }
        end
      end

      it "sets @user" do
        get :edit, params: { id: category.token, user_id: current_user.username}
        expect(assigns(:user)).to eq(current_user)
      end

      it "sets @category" do
        get :edit, params: { id: category.token, user_id: current_user.username}
        expect(assigns(:category)).to eq(category)
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:category) { Fabricate(:category, user: user) }
      before do
        get :edit, params: { id: category.token, user_id: user.id }
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
      let(:category) { Fabricate(:category, user: current_user, name: "old_name") }
      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          patch :update, params: { category: { name: "new_name" }, user_id: current_user.username + 'a', id: category.token }
        end
      end

      context "with valid inputs" do
        before do
          patch :update, params: { category: { name: "new_name" }, user_id: current_user.username, id: category.token }
        end

        it "redirects to the user show page" do
          expect(response).to redirect_to user_path(current_user)
        end

        it "updates a category" do
          expect(Category.first.name).to eq("new_name")
        end

        it "sets the flash success message" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid inputs" do
        let(:category) { Fabricate(:category, name: "old_name", user: current_user) }
        before do
          post :update, params: { category: { name: "" }, user_id: current_user.username, id: category.token }
        end

        it "does not update a category" do
          expect(category.name).to eq('old_name')
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

        it "sets @category" do
          expect(assigns(:category)).to eq(category)
        end
      end
    end

    context "with unauthenticated user" do
      before do
        user = Fabricate(:user)
        category = Fabricate(:category, name: "old_name", user: user)
        post :update, params: { category: { name: "new_name" }, user_id: user.id, id: category.token }
      end

      it "does not update the category" do
        expect(Category.first.name).to eq("old_name")
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
