require 'rails_helper'

RSpec.describe Product, type: :model do
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
      name: "Test",
      description:"desc",
      category:"test",
      price:10,
      stock:5,
      user:user
    )
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to be_valid
  end
  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to be_valid
  end
  it "is not valid without a category" do
    subject.category = nil
    expect(subject).to be_valid
  end
  it "is not valid without a price" do
    subject.price = nil
    expect(subject).to be_valid
  end
  it "is not valid without a stock" do
    subject.stock = nil
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
  end
end
