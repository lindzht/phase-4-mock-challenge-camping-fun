class CampersController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found
rescue_from ActiveRecord::RecordInvalid, with: :camper_invalid

    def index
        campers = Camper.all
        render json: campers, except: [:created_at, :updated_at], status: :ok
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperwithactivitySerializer
    end

    def create 
        camper = Camper.create!(params_camper)
        render json: camper, status: :created
    end

    private

    def params_camper
        params.permit(:name, :age)
    end

    def camper_not_found
        render json: {error: "Camper not found" }, status: :not_found
    end

    def camper_invalid(exception)
        render json: {errors: [exception.record.errors.full_messages]}, status: :unprocessable_entity
    end


end
