class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user
  enum status: [:pending, :shipped, :deliveried, :cancelled]
end
