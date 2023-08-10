require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all groups to @groups' do
      group1 = Group.create(name: 'Food', icon: 'food.jpg', user:)
      group2 = Group.create(name: 'Clothing', icon: 'clothing.jpg', user:)

      get :index
      expect(assigns(:groups)).to eq([group1, group2])
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new group to @group' do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'assigns a list of categories to @categories' do
      get :new
      expect(assigns(:categories)).to be_an(Array)
    end
  end

  describe 'DELETE #destroy' do
    let!(:group) { Group.create(name: 'Food', icon: 'food.jpg', user:) }

    it 'destroys the group' do
      expect do
        delete :destroy, params: { id: group.id }
      end.to change(Group, :count).by(-1)
    end

    it 'redirects to groups_path after deletion' do
      delete :destroy, params: { id: group.id }
      expect(response).to redirect_to(groups_path)
    end
  end
end
