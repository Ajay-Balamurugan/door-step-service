class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_admin

  enum role: { customer: 0, employee: 1, admin: 2 }

  has_one :customer, dependent: :destroy
  has_one :employee, dependent: :destroy
  has_one :admin, dependent: :destroy

 
  accepts_nested_attributes_for :customer, allow_destroy: true
  accepts_nested_attributes_for :employee, allow_destroy: true

  private

  def create_admin
    if self.admin?
      Admin.create(user_id: self.id)
    end
  end

end
