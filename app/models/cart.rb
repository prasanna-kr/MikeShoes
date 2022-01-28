class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, :dependent => :destroy
  
  def add_product(product_id,quantity)
    current_item = line_items.find_by_product_id(product_id)
    p "currentItem>>>>>>>>>#{current_item.inspect}"
    p "currentItem>>>>>>>>>#{quantity}"
    if current_item
      current_item.quantity = quantity
    else
      current_item = line_items.build(:product_id => product_id,:quantity => quantity)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end 

  def get_cart_count 
    cart = Cart.find(session[:cart_id])
    p "Cart >>>>>>>#{cart.inspect}"
    rescue ActiveRecord::RecordNotFound
    return 0
  end
  
end
