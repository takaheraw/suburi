require 'spec_helper'

RSpec.describe UserDecorator do
  let(:user) { User.new.extend UserDecorator }
  subject { user }
  it { should be_a User }
end
