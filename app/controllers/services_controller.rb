class ServicesController < ApplicationController
   skip_before_action :verify_authenticity_token

   def index
      @service = Service.new
      @services = Service.order(created_at: :desc)
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
         image_urls = @service.images.map do |image|
            variant = image.variant(resize_to_fill: [150, 150]).processed
            rails_representation_url(variant)
         end
         render json: { message: "Service was successfully updated", service: @service, image_urls: image_urls }, status: :ok
      else
         render json: @service.errors, status: :unprocessable_entity
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