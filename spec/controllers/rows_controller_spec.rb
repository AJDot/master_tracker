describe RowsController do
  describe "POST create" do
    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      let(:spreadsheet) { Fabricate(:spreadsheet, user: current_user) }

      context "with at least one category, skill, and description created for user" do
        before do
          Fabricate(:category, user: current_user)
          Fabricate(:skill, user: current_user)
          Fabricate(:description, user: current_user)
          session[:user_id] = current_user.id
          post :create, format: 'js', params: { spreadsheet_id: spreadsheet.token, user_id: current_user.id }
        end

        it "creates an row" do
          expect(Row.count).to eq(1)
        end

        it "creates a row associated with the spreadsheet" do
          expect(spreadsheet.rows.count).to eq(1)
        end

        it "renders the :add js template" do
          expect(response).to render_template :add
        end
      end

      context "without at least one category, skill, and description created for user" do
        before do
          session[:user_id] = current_user.id
          post :create, format: 'js', params: { spreadsheet_id: spreadsheet.token, user_id: current_user.id }
        end

        it "sets the flash danger message" do
          expect(flash[:danger]).not_to be_blank
        end

        it "renders the :no_traits js template" do
          expect(response).to render_template :no_traits
        end
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:spreadsheet) { Fabricate(:spreadsheet, user: user) }
      before do
        Fabricate(:category, user: user)
        Fabricate(:skill, user: user)
        Fabricate(:description, user: user)
        post :create, format: 'js', params: { spreadsheet_id: spreadsheet.token, user_id: user.id }
      end

      it "does not create a row" do
        expect(Spreadsheet.first.rows.count).to eq(0)
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
