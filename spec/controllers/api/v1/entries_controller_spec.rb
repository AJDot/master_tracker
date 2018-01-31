describe API::V1::EntriesController do
  describe "GET index" do
    let(:user) { Fabricate(:user) }
    let(:category) { Fabricate(:category, user: user) }
    let(:skill) { Fabricate(:skill, user: user) }
    let(:description) { Fabricate(:description, user: user) }
    before do
      entry1 = Fabricate(:entry, user: user, category: category, skill: skill, description: description)
      entry2 = Fabricate(:entry, user: user, category: category, skill: skill, description: description)
      headers = {
        "ACCEPT" => "application/json",     # This is what Rails 4 accepts
        "HTTP_ACCEPT" => "application/json" # This is what Rails 3 accepts
      }
      get "/api/v1/users/#{user.id}/entries.json", params: {
        category: {
          id: category.id,
          value: category.name
        },
        skill: {
          id: skill.id,
          value: skill.name
        },
        description: {
          id: description.id,
          value: description.name
        }
      }, headers: headers
    end

    it "returns a json response", type: :request do
      expect(response.content_type).to eq("application/json")
    end

    it "returns entries for date ranges", type: :request do
      expect(response.body).to include("all_time")
      expect(response.body).to include("today")
      expect(response.body).to include("yesterday")
      expect(response.body).to include("this_month")
    end
  end
end
