class CustomersController < ApplicationController
    def home

    end

    def new
       @customer = Customer.new
       @customer.build_user
    end
  
    def create
      @customer = Customer.new(customer_params)
      if @customer.save
        user = @customer.user
        sign_in(user)
        redirect_to root_path, notice: "Logged in as Customer"
      else
        render :new, alert: "Unable to create User"
      end
    end

    def edit

    end

    def update

    end
   
    private

    def customer_params
    params.require(:customer).permit(:address, :phone_number,user_attributes: [:name, :email, :password, :password_confirmation])
    end
end
   