class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  enum role: [:admin, :buyer]
  after_initialize :set_default_role
  
  private
    def set_default_role
      self.role ||= :buyer
    end
end
