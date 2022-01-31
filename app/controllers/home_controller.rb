class HomeController < ApplicationController
  def index
    @current_cart = current_cart
  end
end
