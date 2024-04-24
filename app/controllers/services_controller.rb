class ServicesController < ApplicationController
    def index
        @services = Service.all
    end
    
    def new
       @service = Service.new
    end
 
    def create
       @service = Service.new(service_params)
       if @service.save
          redirect_to admin_dashboard_path, notice: "Successfully Created Service"
       else
          render :new
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
 
    private
 
    def service_params
       params.require(:service).permit(:title, :description, images: [])
    end
 
end