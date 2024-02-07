module Api
  module V1
    class DestinationsController < ActionController::API
      before_action :set_destination, only: %i[show update destroy]
      rescue_from ActionController::UnpermittedParameters, with: :invalid_patch_info
      rescue_from ActionController::ParameterMissing, with: :invalid_strong_params
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def index
        render json: DestinationSerializer.new(Destination.all), status: :ok
      end

      def show
        # @destination_weather = WeatherFacade.new.current_weather_in(@destination.zip)
        # @current_weather_gif = ImageFacade.new.image_of(@destination_weather.summary)
        render json: DestinationSerializer.new(@destination), status: :ok
      end

      def create
        @destination = Destination.new(destination_params)
        if @destination.save
          render json: DestinationSerializer.new(@destination), status: :created
        else
          render json: ErrorSerializer.not_created(@destination.errors), status: :not_acceptable
        end
      end

      def update
        @destination.update(destination_params)
        render json: DestinationSerializer.new(@destination), status: :accepted
      end

      def destroy
        @destination.destroy
        render json: DestinationSerializer.new(Destination.all), status: :ok
      end

      private

      # 404 error when resource not found to show
      def not_found(error)
        render json: ErrorSerializer.new(error).not_found, status: :not_found
      end

      # Render errors when updating with invalid strong params
      # 406 error for missing strong params
      def invalid_strong_params
        render json: ErrorSerializer.invalid_strong_params, status: :not_acceptable
      end

      # 406 error for invalid attributes
      def invalid_patch_info(error)
        render json: ErrorSerializer.invalid_patch(error), status: :not_acceptable
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_destination
        @destination = Destination.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def destination_params
        params.require(:destination).permit(:name, :zip, :description, :image_url)
      end
    end
  end
end
