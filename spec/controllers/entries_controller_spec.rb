describe EntriesController do
  describe "GET index" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          get :index, params: { user_id: current_user.username + 'a' }
        end
      end

      it "sets @entries" do
        get :index, params: { user_id: current_user.username }
        expect(assigns(:entries)).to eq(current_user.entries)
      end

      it "sets @user" do
        get :index, params: { user_id: current_user.username }
        expect(assigns(:user)).to eq(current_user)
      end
    end

    context "with unauthenticated user" do
      it "redirects to login path" do
        get :index, params: { user_id: Fabricate(:user).id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET new" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          get :new, params: { user_id: current_user.username + 'a' }
        end
      end

      it "sets @entry to new entry" do
        get :new, params: { user_id: current_user.username }
        expect(assigns(:entry)).to be_new_record
        expect(assigns(:entry)).to be_instance_of(Entry)
      end

      it "sets @user" do
        get :new, params: { user_id: current_user.username }
        expect(assigns(:user)).to eq(current_user)
      end
    end

    context "with unauthenticated user" do
      it "redirects to login path" do
        get :new, params: { user_id: Fabricate(:user).id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          post :create, params: { entry: Fabricate.attributes_for(:entry), user_id: current_user.username + 'a' }
        end
      end

      context "with valid inputs" do
        before do
          post :create, params: { entry: Fabricate.attributes_for(:entry), user_id: current_user.username }
        end

        it "creates an entry" do
          expect(Entry.count).to eq(1)
        end

        it "creates an entry associated with the signed in user" do
          expect(current_user.entries.count).to eq(1)
        end

        it "redirects to the user entries index page" do
          expect(response).to redirect_to user_entries_path(current_user)
        end

        it "sets the flash success message" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid inputs" do
        before do
          post :create, params: { entry: Fabricate.attributes_for(:entry, skill: nil), user_id: current_user.username }
        end

        it "does not create an entry" do
          expect(Entry.count).to eq(0)
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end

        it "sets @entry" do
          expect(assigns(:entry)).to be_new_record
          expect(assigns(:entry).skill).to be_nil
        end
      end
    end

    context "with unauthenticated user" do
      before do
        post :create, params: { entry: Fabricate.attributes_for(:entry), user_id: 1 }
      end

      it "redirects to login path" do
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
      let(:entry) { Fabricate(:entry, user: current_user) }

      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          get :edit, params: { id: entry.token, user_id: current_user.username + 'a' }
        end
      end

      it "sets @user" do
        get :edit, params: { id: entry.token, user_id: current_user.username }
        expect(assigns(:user)).to eq(current_user)
      end

      it "sets @entry" do
        get :edit, params: { id: entry.token, user_id: current_user.username }
        expect(assigns(:entry)).to eq(entry)
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:entry) { Fabricate(:entry, user: user) }

      before do
        get :edit, params: { id: entry.token, user_id: user.id }
      end

      it "redirects to login path" do
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
      let(:entry) { Fabricate(:entry, user: current_user, duration: 60) }
      before do
        session[:user_id] = current_user.id
      end

      it_behaves_like "user must own the page" do
        let(:action) do
          patch :update, params: { entry: { duration: 120 }, user_id: current_user.username + 'a', id: entry.token }
        end
      end

      context "with valid inputs" do
        before do
          patch :update, params: { entry: { duration: 120 }, user_id: current_user.username, id: entry.token }
        end

        it "redirects to the user's entries index page" do
          expect(response).to redirect_to user_entries_path(current_user)
        end

        it "updates the entry" do
          expect(Entry.first.duration).to eq(120)
        end

        it "sets the flash success message" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid inputs" do
        before do
          patch :update, params: { entry: { duration: 0 }, user_id: current_user.username, id: entry.token }
        end

        it "does not update an entry" do
          expect(entry.duration).to eq(60)
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

        it "sets @entry" do
          expect(assigns(:entry)).to eq(entry)
        end
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:entry) { Fabricate(:entry, user: user, duration: 60) }
      before do
        patch :update, params: { entry: { duration: 120 }, user_id: user.id, id: entry.token }
      end

      it "does not update the entry" do
        expect(Entry.first.duration).to eq(60)
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
