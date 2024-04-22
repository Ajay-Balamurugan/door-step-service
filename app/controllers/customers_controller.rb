class CustomersController < ApplicationController
    def home

    end

    def new
       @customer = Customer.new
       @customer.build_user

    end
  

    def create
      if Customer.create!(customer_params)
        redirect_to root_path, notice: "Logged in as Customer"
      end
    end
   
    private

    def customer_params
    params.require(:customer).permit(:address, :phone_number,user_attributes: [:name, :email, :password, :password_confirmation])
    end
end
   