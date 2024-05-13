class OptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_option, only: %i[update destroy]
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

  def update
    service = @option.service
    if @option.update(option_params)
      render partial: 'option', locals: { option: @option, service: }, status: :ok
    else
      render json: { message: 'Unable to Update Option.' }, status: :unprocessable_entity
    end
  end

  def destroy
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

  def set_option
    @option = Option.find(params[:id])
  end
end
