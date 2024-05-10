class ServicesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin, except: [:show]

  def index
    @service = Service.new
    @services = Service.order(created_at: :desc)
  end

  def new
    @service = Service.new
  end

  def show
    @service = Service.find(params[:id])
    @option = Option.new
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
      render partial: 'service', locals: { service: @service }, status: :ok
    else
      render json: { message: 'Error! Unable to Update Service' }, status: :unprocessable_entity
    end
  end

  def destroy
    @service = Service.find(params[:id])
    if @service.destroy
      render json: { message: 'Succesfully deleted service' }, status: :ok
    else
      render json: { message: 'Error! Unable to delete Service' }, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:service).permit(:title, :description, images: [])
  end

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorized to visit the page' unless user_is_admin?
  end
end
