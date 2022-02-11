class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates_uniqueness_of :product_id, :scope => :user_id, :message => "Product already added to wishlist"
end
