require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  it "is valid with valid attributes" do
    group = Group.new(name: "Food", icon: "food.jpg", user: user)
    expect(group).to be_valid
  end

  it "is not valid without a name" do
    group = Group.new(icon: "food.jpg", user: user)
    expect(group).not_to be_valid
  end

  it "is not valid without an icon" do
    group = Group.new(name: "Food", user: user)
    expect(group).not_to be_valid
  end

  it "is not valid without a user" do
    group = Group.new(name: "Food", icon: "food.jpg")
    expect(group).not_to be_valid
  end

  describe "#total" do
    it "returns 0 if there are no activities in the group" do
      group = Group.create(name: "Food", icon: "food.jpg", user: user)
      expect(group.total).to eq(0)
    end
  end
end
