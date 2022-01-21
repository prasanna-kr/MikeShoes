class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    protect_from_forgery with: :exception       

    
    private
        def user_not_authorized
            flash[:warning] = "You are not authorized to perform this action."
            redirect_to(request.referrer || root_path)
        end

        def current_cart
            Cart.find(session[:cart_id])
            rescue ActiveRecord::RecordNotFound
            cart = Cart.create(:user_id => current_user.id)
            session[:cart_id] = cart.id
            cart
        end
end
