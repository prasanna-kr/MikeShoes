# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin
    include Administrate::Punditize
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    def authenticate_admin
      # TODO Add authentication logic here.
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
    private
      def user_not_authorized
          flash[:warning] = "You are not authorized to perform this action."
          redirect_to(request.referrer || root_path)
      end
  end
end
