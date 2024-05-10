class OptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin

  def new
    @option = Option.new
  end

  def create
    service = Service.find(params[:service_id])
    @option = service.options.new(option_params)
    if @option.save
      render partial: 'option', locals: { option: @option, service: }, status: :created
    else
      render json: { message: 'Unable to Create Option.' }, status: :unprocessable_entity
    end
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    service = @option.service
    if @option.update(option_params)
      render partial: 'option', locals: { option: @option, service: }, status: :ok
    else
      render json: { message: 'Unable to Update Option.' }, status: :unprocessable_entity
    end
  end

  def destroy
    @option = Option.find(params[:id])
    if @option.destroy
      render json: { message: 'Succesfully deleted option' }, status: :ok
    else
      render json: { message: 'Error! Unable to delete option' }, status: :unprocessable_entity
    end
  end

  private

  def option_params
    params.require(:option).permit(:title, :description, :price, :service_id, :duration)
  end

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorized to visit the page' unless user_is_admin?
  end
end
