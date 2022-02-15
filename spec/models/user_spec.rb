require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject {
    described_class.new(email: "prasanna.k.r@accenture.com", password: "welcome", role: "buyer")
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "is not valid without a email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a role" do
    user = User.new(role: nil)
    expect(user).to_not be_valid
  end
  it "is not valid without a password" do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end
end