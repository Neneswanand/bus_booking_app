class RoutesController < ApplicationController
  def create 
    route = Route.new(route_params)

    if route.save
      render json: route, status: :created
    else
      render json: {
        errors: route.errors.full_messages
      }, status: :unprocessable_entity
    end
  end



  private

  def route_params
    params.require(:route).permit(:source, :destination, :distance)
  end
end
