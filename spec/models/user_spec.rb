require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { build(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  describe "validations" do
    it { expect(user).to_not allow_value("takaheraw").for(:email) }
  end

  describe "associations" do
    it { expect(user).to define_enum_for(:role).with_values({user: 0, moderator: 1, admin: 2}).with_prefix(:role) }
  end

  describe "scopes" do
  end

  describe "public instance methods" do
  end

  describe "public class methods" do
  end
end
