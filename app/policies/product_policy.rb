class ProductPolicy < ApplicationPolicy
    def index?
      true
    end
  
    def show?
      user.role == "admin" || user.role == "buyer"
    end

    def create?
      user.role == "admin"
    end
  
    def update?
        user.role == "admin"
    end
  
    def destroy?
        user.role == "admin"
    end
  
    private
  
      def product
        record
      end
end