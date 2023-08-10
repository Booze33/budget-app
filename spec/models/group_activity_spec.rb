require 'rails_helper'

RSpec.describe GroupActivity, type: :model do
  describe 'associations' do
    it 'belongs to a group' do
      association = described_class.reflect_on_association(:group)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to an activity' do
      association = described_class.reflect_on_association(:activity)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
