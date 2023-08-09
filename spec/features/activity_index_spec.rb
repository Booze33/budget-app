require 'rails_helper'

RSpec.describe 'groups/show', type: :view do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:group) { Group.create(name: 'Food', icon: 'food.jpg', user: user) }
  let(:activity1) { Activity.create(name: 'Lunch', amount: 10, author: user) }
  let(:activity2) { Activity.create(name: 'Dinner', amount: 15, author: user) }

  before do
    assign(:group, group)
    assign(:activities, [activity1, activity2])
    render
  end

  it 'displays group name' do
    expect(rendered).to have_content(group.name)
  end
end
