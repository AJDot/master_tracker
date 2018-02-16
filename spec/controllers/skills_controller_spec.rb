describe SkillsController, type: :controller do
  describe "GET new" do
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        get :new, params: { user_id: current_user.id }
      end

      it "sets @skill" do
        expect(assigns(:skill)).to be_new_record
        expect(assigns(:skill)).to be_instance_of(Skill)
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
          post :create, params: { skill: { name: "new_skill" }, user_id: current_user.id }
        end

        it "redirects to the user show page" do
          expect(response).to redirect_to user_path(current_user)
        end

        it "creates a skill" do
          expect(Skill.count).to eq(1)
        end

        it "create a skill associated with the signed in user" do
          expect(Skill.first.user).to eq(current_user)
        end
      end

      context "with invalid inputs" do
        before do
          post :create, params: { skill: { name: "" }, user_id: current_user.id }
        end

        it "does not create a skill" do
          expect(Skill.count).to eq(0)
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end

        it "sets @skill" do
          expect(assigns(:skill)).to be_new_record
          expect(assigns(:skill).name).to eq("")
        end
      end
    end

    context "with unauthenticated users" do
      before do
        post :create, params: { skill: { name: "new_skill" }, user_id: 1 }
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
      let(:skill) { Fabricate(:skill, user: current_user) }
      before do
        session[:user_id] = current_user.id
        get :edit, params: { id: skill.token, user_id: current_user.id}
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(current_user)
      end

      it "sets @skill" do
        expect(assigns(:skill)).to eq(skill)
      end
    end

    context "with unauthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:skill) { Fabricate(:skill, user: user) }
      before do
        get :edit, params: { id: skill.token, user_id: user.id }
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
      let(:skill) { Fabricate(:skill, user: current_user, name: "old_name") }
      before do
        session[:user_id] = current_user.id
      end

      context "with valid inputs" do
        before do
          patch :update, params: { skill: { name: "new_name" }, user_id: current_user.id, id: skill.token }
        end

        it "redirects to the user show page" do
          expect(response).to redirect_to user_path(current_user)
        end

        it "updates a skill" do
          expect(Skill.first.name).to eq("new_name")
        end

        it "sets the flash success message" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid inputs" do
        let(:skill) { Fabricate(:skill, name: "old_name", user: current_user) }
        before do
          post :update, params: { skill: { name: "" }, user_id: current_user.id, id: skill.token }
        end

        it "does not update a skill" do
          expect(skill.name).to eq('old_name')
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

        it "sets @skill" do
          expect(assigns(:skill)).to eq(skill)
        end
      end
    end

    context "with unauthenticated user" do
      before do
        user = Fabricate(:user)
        skill = Fabricate(:skill, name: "old_name", user: user)
        post :update, params: { skill: { name: "new_name" }, user_id: user.id, id: skill.token }
      end

      it "does not update the skill" do
        expect(Skill.first.name).to eq("old_name")
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
