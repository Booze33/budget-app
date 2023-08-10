require 'rails_helper'

RSpec.describe 'groups/new', type: :view do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:categories) do
    %w[Studies Housing Transportation Foods Utilities Clothing Healthcare Entertainment Personal Savings]
  end

  before do
    assign(:group, Group.new)
    assign(:categories, categories)
    render
  end

  it 'displays a form for creating a new group' do
    expect(rendered).to have_selector('form')
  end

  it 'displays a select field for choosing a category' do
    expect(rendered).to have_selector('select[name="group[name]"]')
    expect(rendered).to have_selector('option', count: categories.size + 1)
  end

  it 'displays a "Add category" submit button' do
    expect(rendered).to have_selector('input[type="submit"][value="Add category"]')
  end

  it 'displays a "Back" link' do
    expect(rendered).to have_link('Back', href: groups_path)
  end
end
