class ServicesController < ApplicationController
    def index
      @service = Service.new
      @services = Service.all
    end
    
    def new
       @service = Service.new
    end
 

   def create
      @service = Service.new(service_params)
      if @service.save
         render partial: 'service', locals: { service: @service }, status: :created
      else
         render json: { message: 'Unable to Create Service.' }, status: :unprocessable_entity
      end
   end
 
    def edit
       @service = Service.find(params[:id])
    end
 
    def update
       @service = Service.find(params[:id])
       if @service.update(service_params)
          redirect_to services_path, notice: "Service was successfully updated."
       else
          render :edit
       end
    end

    def destroy
      @service = Service.find(params[:id])
      @service.destroy
      redirect_to services_path, notice: "Successfully deleted services"
    end
 
    private
 
    def service_params
       params.require(:service).permit(:title, :description, images: [])
    end

end