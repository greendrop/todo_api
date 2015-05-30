require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe "enumerize" do
    it { should enumerize(:state).in(:none, :done).with_default(:none) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validates" do
    context 'user' do
      it { is_expected.to validate_presence_of(:user) }
    end

    context 'title' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_most(255) }
    end

    context 'state' do
      it { is_expected.to validate_presence_of(:state) }
    end
  end
end
