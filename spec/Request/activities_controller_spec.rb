require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:group) { Group.create(name: "Food", icon: "food.jpg", user: user) }

  describe "GET #index" do
    it "renders the index template" do
      get :index, params: { group_id: group.id }
      expect(response).to render_template(:index)
    end

    it "assigns the group to @group" do
      get :index, params: { group_id: group.id }
      expect(assigns(:group)).to eq(group)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new, params: { group_id: group.id }
      expect(response).to render_template(:new)
    end

    it "assigns a new activity to @activity" do
      get :new, params: { group_id: group.id }
      expect(assigns(:activity)).to be_a_new(Activity)
    end
  end
end
