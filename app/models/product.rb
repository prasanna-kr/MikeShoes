class Product < ApplicationRecord
    has_one_attached :product_image, dependent: :purge
    has_many :line_items, :dependent => :destroy
    belongs_to :user
    extend FriendlyId
    friendly_id :name, use: :slugged
    def get_line_items_quantity(cartId)
        p "current_cart>>>>>>>>>>#{cartId}"
        current_item = LineItem.find_by_product_id_and_cart_id(self.id,cartId)
        p "current_item>>>>>>>>>>#{current_item}"
        if current_item
            current_item.quantity
        else
            return 1
        end
    end
end
