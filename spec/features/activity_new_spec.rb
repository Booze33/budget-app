require 'rails_helper'

RSpec.describe 'activities/new', type: :view do
  before do
    @activity = Activity.new
    @id = 1
    @name = 'Food'
    @group = Group.create(name: 'Food', icon: 'food.jpg')
    assign(:activity, @activity)
    assign(:id, @id)
    assign(:name, @name)
    assign(:group, @group)
    render
  end

  it 'displays activity form' do
    expect(rendered).to have_selector('form[action="/groups/1/activities"]')
    expect(rendered).to have_field('Name')
    expect(rendered).to have_field('Amount')
    expect(rendered).to have_field('Category', disabled: true, with: 'Food')
    expect(rendered).to have_button('Add transaction')
  end

  it 'renders form labels' do
    expect(rendered).to have_selector('label', text: 'Name')
    expect(rendered).to have_selector('label', text: 'Amount')
    expect(rendered).to have_selector('label', text: 'Category')
  end

  it 'renders required input fields' do
    expect(rendered).to have_selector('input[type="text"][name="activity[name]"][required]')
    expect(rendered).to have_selector('input[type="number"][name="activity[amount]"][required]')
  end

  it 'renders submit button' do
    expect(rendered).to have_button('Add transaction')
  end

  it 'displays correct form action URL' do
    expect(rendered).to have_selector('form[action="/groups/1/activities"]')
  end

  it 'displays correct category value' do
    expect(rendered).to have_field('Category', with: 'Food', disabled: true)
  end

  it 'displays the form within the register-container' do
    expect(rendered).to have_selector('.register-container form')
  end
end
