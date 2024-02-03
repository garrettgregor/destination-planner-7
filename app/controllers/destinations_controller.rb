class DestinationsController < ApplicationController
  before_action :set_destination, only: %i[show edit update destroy]

  def index
    @destinations = Destination.all
  end

  def show
    @destination_weather = WeatherFacade.new.current_weather_in(@destination.zip)
    @current_weather_gif = ImageFacade.new.image_of(@destination_weather.summary)
  end

  def new
    @destination = Destination.new
  end

  def edit; end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to @destination, notice: "Destination was successfully created."
    else
      render :new
    end
  end

  def update
    if @destination.update(destination_params)
      redirect_to @destination, notice: "Destination was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @destination.destroy
    redirect_to destinations_path, notice: "Destination was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_destination
    @destination = Destination.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def destination_params
    params.require(:destination).permit(:name, :zip, :description, :image_url)
  end
end
