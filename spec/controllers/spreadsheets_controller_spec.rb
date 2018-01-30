describe SpreadsheetsController do
  describe "GET show" do

    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      let(:spreadsheet) { Fabricate(:spreadsheet, user: current_user)}
      before do
        session[:user_id] = current_user.id
        get :show, params: { id: spreadsheet.id, user_id: current_user.id }
      end

      it "sets @spreadsheet" do
        expect(assigns(:spreadsheet)).to eq(spreadsheet)
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(current_user)
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:spreadsheet) { Fabricate(:spreadsheet, user: user)}
      it "redirects to login path" do
        get :show, params: { id: spreadsheet.id, user_id: user.id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET new" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        get :new, params: { user_id: current_user.id }
      end

      it "sets @spreadsheet to new spreadsheet" do
        expect(assigns(:spreadsheet)).to be_new_record
        expect(assigns(:spreadsheet)).to be_instance_of(Spreadsheet)
      end

      it "sets @user" do
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

      context "with valid inputs" do
        before do
          post :create, params: { spreadsheet: Fabricate.attributes_for(:spreadsheet), user_id: current_user.id }
        end

        it "creates an spreadsheet" do
          expect(Spreadsheet.count).to eq(1)
        end

        it "creates an spreadsheet associated with the signed in user" do
          expect(current_user.spreadsheets.count).to eq(1)
        end

        it "redirects to the user spreadsheet show page" do
          expect(response).to redirect_to user_spreadsheet_path(current_user, Spreadsheet.first)
        end

        it "sets the flash success message" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid inputs" do
        before do
          post :create, params: { spreadsheet: Fabricate.attributes_for(:spreadsheet, name: ""), user_id: current_user.id }
        end

        it "does not create a spreadsheet" do
          expect(Spreadsheet.count).to eq(0)
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end

        it "sets @spreadsheet" do
          expect(assigns(:spreadsheet)).to be_new_record
          expect(assigns(:spreadsheet).name).to be_blank
        end
      end
    end

    context "with unauthenticated user" do
      before do
        post :create, params: { spreadsheet: Fabricate.attributes_for(:spreadsheet), user_id: 1 }
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
      let(:spreadsheet) { Fabricate(:spreadsheet, user: current_user) }

      before do
        session[:user_id] = current_user.id
        get :edit, params: { id: spreadsheet.id, user_id: current_user.id }
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(current_user)
      end

      it "sets @spreadsheet" do
        expect(assigns(:spreadsheet)).to eq(spreadsheet)
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:spreadsheet) { Fabricate(:spreadsheet, user: user) }

      before do
        get :edit, params: { id: spreadsheet.id, user_id: user.id }
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
      let(:spreadsheet) { Fabricate(:spreadsheet, user: current_user, name: "old_name") }
      before do
        session[:user_id] = current_user.id
      end

      context "with valid inputs" do
        before do
          patch :update, params: { spreadsheet: { name: "new_name" }, user_id: current_user.id, id: spreadsheet.id }
        end

        it "redirects to the user's spreadsheet show page" do
          expect(response).to redirect_to user_spreadsheet_path(current_user, spreadsheet)
        end

        it "updates the spreadsheet" do
          expect(Spreadsheet.first.name).to eq("new_name")
        end

        it "sets the flash success message" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid inputs" do
        before do
          patch :update, params: { spreadsheet: { name: "" }, user_id: current_user.id, id: spreadsheet.id }
        end

        it "does not update an spreadsheet" do
          expect(Spreadsheet.first.name).to eq("old_name")
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

        it "sets @spreadsheet" do
          expect(assigns(:spreadsheet)).to eq(spreadsheet)
        end
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:spreadsheet) { Fabricate(:spreadsheet, user: user, name: "old_name") }
      before do
        patch :update, params: { spreadsheet: { duration: "new_name" }, user_id: user.id, id: spreadsheet.id }
      end

      it "does not update the spreadsheet" do
        expect(Spreadsheet.first.name).to eq("old_name")
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
