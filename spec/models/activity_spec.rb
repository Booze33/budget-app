require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  it "is valid with valid attributes" do
    activity = Activity.new(name: "Groceries", amount: 50, author: user)
    expect(activity).to be_valid
  end

  it "is not valid without a name" do
    activity = Activity.new(amount: 50, author: user)
    expect(activity).not_to be_valid
  end

  it "is not valid without an amount" do
    activity = Activity.new(name: "Groceries", author: user)
    expect(activity).not_to be_valid
  end

  it "is not valid without an author" do
    activity = Activity.new(name: "Groceries", amount: 50)
    expect(activity).not_to be_valid
  end

  it "is not valid if amount is negative" do
    activity = Activity.new(name: "Groceries", amount: -10, author: user)
    expect(activity).not_to be_valid
  end

  describe "associations" do
    it "belongs to an author" do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end

    it "has many group_activities" do
      association = described_class.reflect_on_association(:group_activities)
      expect(association.macro).to eq(:has_many)
    end

    it "has many groups through group_activities" do
      association = described_class.reflect_on_association(:groups)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:group_activities)
    end
  end
end
