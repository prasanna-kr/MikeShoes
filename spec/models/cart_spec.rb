require 'rails_helper'

RSpec.describe Cart, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) {
    User.new(
      email:"prasanna.k.r@accenture.com",
      role:"buyer",
      password:"welcome"
    )
  }
  subject {
    described_class.new(
      user:user
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
  end
end
