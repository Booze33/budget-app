require 'rails_helper'

RSpec.describe 'groups/index', type: :view do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:group1) { Group.create(name: 'Food', icon: 'food.jpg', user: user) }
  let(:group2) { Group.create(name: 'Studies', icon: 'studies.jpg', user: user) }

  before do
    assign(:groups, [group1, group2])
    allow(view).to receive(:can?).and_return(true)
    render
  end

  it 'displays group total amount' do
    expect(rendered).to have_content("Total Amount: $0", count: 0)
  end

  it 'displays "New Category" link' do
    expect(rendered).to have_link('New Category', href: new_group_path)
  end
end
