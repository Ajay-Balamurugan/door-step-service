class OptionsController < ApplicationController
    skip_before_action :verify_authenticity_token


   def index
    #   @service = Service.new
    #   @services = Service.order(created_at: :desc)
        @options = Option.all
    end
    
    def new
       @option = Option.new
    end
    

   def create
      @option = Option.new(option_params)
      if @option.save
         render partial: 'option', locals: { option: @option }, status: :created
      else
         render json: { message: 'Unable to Create Option.' }, status: :unprocessable_entity
      end
   end
 
    def edit
       @option = Option.find(params[:id])
    end
 
    def update
      @option = Option.find(params[:id])
      if @option.update(option_params)
         render json: { message: "option was successfully updated", option: @option}, status: :ok
      else
         render json: @option.errors, status: :unprocessable_entity
      end
    end
    

    def destroy
      @option = Option.find(params[:id])
      @option.destroy
      redirect_to service_path, notice: "Successfully deleted Option"
    end
 
    private
 
    def option_params
       params.require(:option).permit(:title, :description, :price)
    end

end